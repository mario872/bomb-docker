python -m pip install -r requirements.txt --break-system-packages
mkdir static
mkdir static/css
touch static/css/input.css
touch static/css/output.css
touch templates/index.html
mkdir templates
mkdir
npm init -y
npm i tailwindcss
npx tailwindcss init
npx tailwindcss -i ./static/css/input.css -o ./static/css/output.css --watch