# printreport
# by Candice Manganar
#
# Copies index.html *test*.html *groups*.html in each directory into one html (out.html) file
# and converts it into PDF (one.pdf) using wkhtmltopdf.

workdir=/print/output

echo $0:  $workdir
[ -d $workdir ] && ls -1d $workdir/*result* | while read dir; do
        dir=$dir/html/
        if [ -d $dir ]; then
                echo -e "\nProcessing $dir"
                for htmlfile in index.html *test*.html *groups*.html; do
                        cat $dir/$htmlfile
                        echo "<br><hr><br><br>"
                done > $dir/out.html
                ret=1
                cnt=0
                while [ $ret != "0" ]; do
                        let cnt++
                        wkhtmltopdf $dir/out.html $dir/out.pdf
                        ret=$?
                        if [ $ret != "0" ]; then
                                if [ $cnt -eq 5 ]; then
                                        echo "GIVING UP."
                                        break;
                                fi
                                echo "RETRYING... $cnt"
                        fi
                done
        else
                echo "$0:  __ERROR__"
                echo "          $dir directory does not exist."
        fi
done