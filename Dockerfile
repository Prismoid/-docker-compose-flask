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
