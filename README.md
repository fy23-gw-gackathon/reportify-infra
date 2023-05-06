# インフラストラクチャ定義

![CI](https://github.com/fy23-gw-gackathon/reportify-infra/workflows/CI/badge.svg)

## 概要

本リポジトリは Reportify のインフラストラクチャ設定ファイルを管理しています。

## 構成

### 開発環境

- AWS
- Terraform 1.3.7
  - [tfenv](https://github.com/tfutils/tfenv) でバージョン管理することを強く推奨します

### ファイルストラクチャ

[Terraform を使用するためのベストプラクティス](https://cloud.google.com/docs/terraform/best-practices-for-terraform)
に従って本プロジェクトは構成されています。

```
-- modules/
   -- <service-name>/
      -- main.tf
      -- variables.tf
      -- outputs.tf
   -- ...
-- environments/
   -- dev/
      -- main.tf
      -- backend.tf
      -- provider.tf
      -- secrets.yaml
   -- qa/
      -- main.tf
      -- backend.tf
      -- provider.tf
      -- secrets.yaml
   -- prod/
      -- main.tf
      -- backend.tf
      -- provider.tf
      -- secrets.yaml
```

## デプロイ手順

```shell
# 環境ディレクトリに移動
# 特別な理由がない限りdev環境にデプロイすること
$ cd environments/<environment name>

# ワークスペースを初期化
$ terraform init

# 実行計画をプレビューし、問題なければデプロイする
$ terraform plan
$ terraform apply
```

## Secrets の管理方法

KMS で Secrets ファイルを暗号化することで、安全に Secrets を管理できます。

Secrets を編集したい場合は、暗号化された Secrets ファイルを復号してから編集内容を適応し、再度暗号化する必要があります。

```shell
$ cd environments/<environment name>

# 暗号化
$ aws kms encrypt --key-id <KMSのキーID> \
    --plaintext fileb://secrets.yaml \
    --output text \
    --query CiphertextBlob > secrets.yaml.encrypted
# 復号
$ aws kms decrypt \
    --ciphertext-blob fileb://<(cat secrets.yaml.encrypted | base64 -d) \
    --output text \
    --query Plaintext | base64 --decode > secrets.yaml
```

