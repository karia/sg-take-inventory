# sg-take-inventory

Check tool for AWS Security Groups via AWS CLI

```
./sg.rb
```

output: csv format

## Japanese

AWSのセキュリティグループを棚卸しするためのツールです。
セキュリティグループの一覧と、各サービス（※）で利用されているか否かがCSV形式で出力されます。

※現在対応しているサービス： EC2, ELBALB,CLB),RDS,ElastiCache,Redshift,Lambda

このほか、他のセキュリティグループのInboundRuleに指定されているセキュリティグループのIDがあれば「OtherSG」欄がYESになります。

### 備考

* 対象のセキュリティグループは VPCのSecurityGroups のみです。他の SecurityGroups 、たとえば RDSの `DBSecurityGroup` などは出力されません。

