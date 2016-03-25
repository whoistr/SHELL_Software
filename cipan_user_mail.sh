cd /home
  du -sh *|
    sort -nr |
      sed 10q |
while read amount name
do
mail -s "disk usage waring" $name  << -EOF 
    Creatings,you are one of the top ten.
    Thanks.
EOF
done

