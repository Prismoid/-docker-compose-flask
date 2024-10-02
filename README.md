# Docker Composeの使い方についてメモOA

## サンプルとするHTTPサーバ(Flask実装、[こちらのWebsite](https://snowsystem.net/container/docker/python-flask-demo/#)を参考)
### ディレクトリ構成(treeコマンドで表示。brewやaptでインストール可)

```txt
.
├──docker-compose.yml
├─ Dockerfile
├── app.py
└── templates
    └── indexml
```

### 各種ファイルについて解説

#### `app.py` コンテナ側のポート5000番でlisten

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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flask App</title>
</head>
<body>
    <h1>Welcome to my Flask app!</h1>
    <p>This is a simple Flask application running inside a Docker container.</p>
</body>
</html>>
```


#### `Dockerfile` (これをベースにイメージからビルド、コンテナを作成する)

```txt
# ベースとなるイメージとして Python 3.12 を使用
FROM python:3.12

# 作業ディレクトリを指定
WORKDIR /app

# ホストのカレントディレクトリの内容を Docker コンテナの /app ディレクトリにコピー
COPY . /app

# Flask をインストール
RUN pip install Flask

# Flask が使用するポートを指定（デフォルトは 5000）
EXPOSE 5000

# コンテナ起動時に実行するコマンドを指定
CMD ["python", "app.py"]
```

#### `docker-compose.yaml` (これを用いることで、複数のコンテナを同時に立ち上げたりできる)

```yaml
version: '3.8'  # Docker Compose のバージョン

services:
  flask-app:  # サービス名（任意）
    build: .  # カレントディレクトリの Dockerfile を使用してビルド
    ports:
      - "5000:5000"  # ホストのポート5000をコンテナのポート5000にマッピング
    volumes:
      - .:/app  # ホストのカレントディレクトリをコンテナの /app にマウント
```