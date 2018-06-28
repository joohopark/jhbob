echo -n "push branch 입력 :"
read branch
echo -n "git commit 메시지 입력:"
read input
git add .
git status
git commit -m "$input"
git push -u origin $branch 
