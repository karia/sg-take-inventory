# sg-take-inventory

## Description

Check tool for AWS Security Groups via AWS CLI

```
ruby ./sg.rb
```

output: csv format

### Japanese

AWSのセキュリティグループを棚卸しするためのツールです。
セキュリティグループの一覧と、各サービス（※）で利用されているか否かがCSV形式で出力されます。
スプレッドシートに貼り付けるなどしてご利用ください。

※現在対応しているサービス： EC2, ELBALB,CLB),RDS,ElastiCache,Redshift,Lambda

上記サービスのほか、他のセキュリティグループのインバウンドルールに指定されているセキュリティグループのIDがあれば「OtherSG」欄がYESになります。

#### 備考

* 対象のセキュリティグループは VPCのSecurityGroups のみです。他の SecurityGroups 、たとえば RDSの `DBSecurityGroup` などは出力されません。

## ToDo

* Please See [Issues](https://github.com/karia/sg-take-inventory/issues)

