# Docker Composeの使い方についてメモOA

## サンプルとするHTTPサーバ(Flask実装、[こちらのWebsite](https://snowsystem.net/container/docker/python-flask-demo/#)を参考)
### ディレクトリ構成(treeコマンドで表示。brewやaptでインストール可)

```txt
.
├ ─docker-compose.yml
├ o Dockerfile
├── app.py
└── templates
    ├── hello.html
    └── index.ht
```

### 各種ファイルについて解説

#### `app.py`

```python
from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

#### `templates/index.html`

```html
<html>
<title>docker demo flask</title>
<head></head>
<body>
トップページです。
</body>
</html>
```


#### `Dockerfile` (これをベースにイメージからビルド、コンテナを作成する)

```txt
# python 3.12 をベースにDockerイメージを作成
FROM python:3.12

# 作業ディレクトリを指定
WORKDIR /app

# カレントディレクトリのファイルをDockerコンテナの｢/app｣ ディレクトリにコピー
ADD . /app

# Flaskをインストール
RUN pip install Flask

# 外部に公開するポートを指定
EXPOSE 8000

# コンテナの実行コマンドを指定
CMD ["python", "app.py"]
```

#### `docker-compose.yaml` (これを用いることで、複数のコンテナを同時に立ち上げたりできる)

```yaml


```