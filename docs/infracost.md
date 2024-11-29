Project: main

 Name                                               Monthly Qty  Unit                    Monthly Cost   
                                                                                                        
 module.vpc.aws_nat_gateway.this[0]                                                                     
 ├─ NAT gateway                                             730  hours                         $32.85   
 └─ Data processed                            Monthly cost depends on usage: $0.045 per GB              
                                                                                                        
 module.vpc.aws_nat_gateway.this[1]                                                                     
 ├─ NAT gateway                                             730  hours                         $32.85   
 └─ Data processed                            Monthly cost depends on usage: $0.045 per GB              
                                                                                                        
 module.alb.aws_lb.this[0]                                                                              
 ├─ Application load balancer                               730  hours                         $16.43   
 └─ Load balancer capacity units              Monthly cost depends on usage: $5.84 per LCU              
                                                                                                        
 aws_kms_key.cloudwatch                                                                                 
 ├─ Customer master key                                       1  months                         $1.00   
 ├─ Requests                                  Monthly cost depends on usage: $0.03 per 10k requests     
 ├─ ECC GenerateDataKeyPair requests          Monthly cost depends on usage: $0.10 per 10k requests     
 └─ RSA GenerateDataKeyPair requests          Monthly cost depends on usage: $0.10 per 10k requests     
                                                                                                        
 aws_kms_key.route53                                                                                    
 ├─ Customer master key                                       1  months                         $1.00   
 └─ Requests (asymmetric)                     Monthly cost depends on usage: $0.15 per 10k requests     
                                                                                                        
 aws_route53_zone.main                                                                                  
 └─ Hosted zone                                               1  months                         $0.50   
                                                                                                        
 aws_cloudwatch_log_group.route53_query_logs                                                            
 ├─ Data ingested                             Monthly cost depends on usage: $0.50 per GB               
 ├─ Archival Storage                          Monthly cost depends on usage: $0.03 per GB               
 └─ Insights queries data scanned             Monthly cost depends on usage: $0.005 per GB              
                                                                                                        
 aws_route53_record.alb                                                                                 
 ├─ Standard queries (first 1B)               Monthly cost depends on usage: $0.40 per 1M queries       
 ├─ Latency based routing queries (first 1B)  Monthly cost depends on usage: $0.60 per 1M queries       
 └─ Geo DNS queries (first 1B)                Monthly cost depends on usage: $0.70 per 1M queries       
                                                                                                        
 OVERALL TOTAL                                                                                $84.63 

*Usage costs can be estimated by updating Infracost Cloud settings, see docs for other options.

──────────────────────────────────
41 cloud resources were detected:
∙ 8 were estimated
∙ 30 were free
∙ 3 are not supported yet, rerun with --show-skipped to see details

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ Project                                            ┃ Baseline cost ┃ Usage cost* ┃ Total cost ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━╋━━━━━━━━━━━━┫
┃ main                                               ┃           $85 ┃           - ┃        $85 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━┛