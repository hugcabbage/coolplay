#!/usr/bin/env bash
get_md5() {
    local file=$1
    md5sum $file | awk '{print $1}'
}

check_md5() {
    local file=$1
    local md5file=$2
    local name=$3
    local md5value=$(get_md5 $file)

    if [ ! -f $md5file ]; then
        touch $md5file
    fi
    
    if [ "$md5value" == "$(cat $md5file)" ]; then
        echo "$name无更新"
        rm -f $file
        return 2
    else
        echo "$name有更新，开始同步到本地……"
        echo $md5value > $md5file
    fi
}

add_and_commit() {
    local change_status=$(git status --porcelain)
    if [ -n "$change_status" ]; then
        echo "[git]检测到有以下文件改动："
        echo "$change_status"

        if [ -t 0 ]; then
            local msg="$1"
        else
            local msg="$1 [auto]"
        fi

        git pull > /dev/null 2>&1
        git add .

        if git commit -m "$msg" > /dev/null 2>&1; then
            echo "[git]改动提交成功"
        else
            echo "[git]改动提交失败，请检查错误或重试！"
            return 1
        fi

    else
        echo "[git]未检测到文件改动"
        return 2
    fi
}

push_to_remote() {
    if git push > /dev/null 2>&1; then
        echo "[git]github推送成功"
    else
        echo "[git]github推送失败，请检查错误或重试！"
    fi

    if git push framagit > /dev/null 2>&1; then
        echo "[git]framagit推送成功"
    else
        echo "[git]framagit推送失败，请检查错误或重试！"
    fi
}

update_gao() {
    cd $dl_dir/
    wget -O gao_tv.zip https://github.com/gaotianliuyun/gao/archive/refs/heads/master.zip > /dev/null 2>&1
    if [ ! -f gao_tv.zip ]; then
        echo "gao_tv.zip下载失败，请检查错误或重试！"
        return 1
    fi

    check_md5 gao_tv.zip gao_tv.md5 gao
    # 无更新则退出当前函数
    if [ $? -eq 2 ]; then
        return 2
    fi

    unzip -o gao_tv.zip > /dev/null
    rm -f gao_tv.zip
    mv -f gao-master gao

    cd gao/
    json-strip-comments 0826.json | jq . --indent 4 > $main_dir/0826.json
    json-strip-comments 9918.json | \
        sed '/{"name":"AV","type":0,"url":".\/livex.m3u"},/d' | \
        sed 's/{"name":"初秋语","type":0,"url":".\/listx.txt"},//' | \
        jq . --indent 4 > $main_dir/9918.json
    mv -f list.txt $main_dir/live_cqy.txt
    mv -f radio.txt $main_dir/radio_cqy.txt

    cd jar/
    mv -f fan.txt $main_dir/jar/
    cd ..

    cd lib/
    mv -f lf_search3_min.js \
        lf_p2p2_min.js \
        lf_live_min.js \
        $main_dir/lib/
    cd ..
    
    cd js/
    mv -f 18av.js \
        Missav.js \
        banan.js \
        drpy.js \
        lf_live1.txt \
        优酷.js \
        养端.js \
        吸瓜.js \
        哔哩直播.js \
        奇珍异兽.js \
        朱古力.js \
        猫了个咪.js \
        玩偶姐姐.js \
        百忙无果.js \
        腾云驾雾.js \
        虎牙直播.js \
        跑TV.js \
        $main_dir/js/
    cd ..

    cd json/
    mv -f pikpakclass.a.json \
        pikpakclass.a.json.db.gz \
        pikpakclass.a1.json \
        pikpakclass.a1.json.db.gz \
        pikpakclass18.json \
        pushshare.a.txt \
        sambashare.a.txt \
        $main_dir/lib/
    cd ..

    cd $main_dir/
    rm -rf $dl_dir/gao

    # 删除md5
    sed -i 's/;md5;.*"/"/g' 9918.json
    
    # 更新XYQ.jar
    wget -O jar/XYQ.jar https://github.com/xyq254245/xyqonlinerule/raw/main/custom_spider.jar > /dev/null 2>&1
    local xyq_md5=$(get_md5 jar/XYQ.jar)
    sed -i "s/md5;.*\"/md5;$xyq_md5\"/g" 0911.json

    # 替换某些路径
    sed -i 's#http://127.0.0.1:9978/file/TV/token.json#file://TV/tokenm.json#g' 9918.json
    sed -i 's#\./json#\./lib#g' 9918.json
    sed -i 's#http://127.0.0.1:9978/file/tvfan/token.txt#file://TV/ali_token.txt#g' 0826.json

    add_and_commit "update gao"
    return $?
}

update_pg() {
    cd $dl_dir/

    # 导出PandaGroovePG最后一个zip文件的json表
    tdl chat export \
        -c PandaGroovePG \
        -T last \
        -i 1 \
        -f "Media.Name endsWith '.zip'" > /dev/null 2>&1

    # 如果tdl-export.json不存在，退出脚本
    if [ ! -f tdl-export.json ]; then
        echo "导出媒体消息失败，请检查错误或重试！"
        return 1
    fi

    check_md5 tdl-export.json pg_export.md5 pg
    # 无更新则退出当前函数
    if [ $? -eq 2 ]; then
        return 2
    fi

    # 下载消息中的媒体文件
    tdl dl -f tdl-export.json -d ./ > /dev/null 2>&1

    # 如果zip文件不存在，退出脚本
    if [ ! -f *.zip ]; then
        echo "zip文件下载失败，请检查错误或重试！"
        return 1
    fi

    # 解压文件
    rm -f tdl-export.json
    rm -rf pg/js/ pg/lib/
    unzip -o *.zip -d pg/ > /dev/null
    rm -f *.zip

    cd pg/

    # 移动文件
    mv -f README.txt $main_dir/README-pg.md
    mv -f pg.jar $main_dir/jar/
    mv -f lib/XBPQ.jar $main_dir/jar/
    mv -f jsm.json $main_dir/pg.json
    mv -f js/* $main_dir/js/
    mv -f $(find lib/ -type f \
        -not -name 'pushshare.txt') $main_dir/lib/

    cd $main_dir/

    # 更正pg.json中的某些路径
    sed -i 's#\./pg.jar#\./jar/pg.jar#g' pg.json
    sed -i 's#\./lib/tokenm.json#file://TV/tokenm.json#g' pg.json
    sed -i 's#\./lib/XBPQ.jar#\./jar/XBPQ.jar#g' pg.json

    # 转简体
    $(dirname $0)/cc.py pg.json
    $(dirname $0)/cc.py README-pg.md

    # md优化
    sed -i '/tokenm.json格式说明：/a ```json' README-pg.md
    sed -i '/}/a ```' README-pg.md
    sed -i '/^$/d' README-pg.md
    sed -i '1,/tokenm.json格式说明：/ s/$/\n/' README-pg.md

    add_and_commit "update pg"
    return $?
}

# ------------主程序------------
main_dir=$(pwd)
dl_dir=$main_dir/download
date

# dl_dir不存在则创建
if [ ! -d $dl_dir ]; then
    mkdir -p $dl_dir
    echo '*' > $dl_dir/.gitignore
fi

update_gao
gao_exit_status=$?
echo ''

update_pg
pg_exit_status=$?
echo ''

if [ $gao_exit_status -eq 0 ] || [ $pg_exit_status -eq 0 ]; then
    push_to_remote
fi
