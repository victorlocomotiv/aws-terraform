import sys
import re

def simplify_terraform_graph(input_content):
    # Extract module names and their relationships
    modules = {
        "aws_provider": "AWS Provider",
        "module.vpc": "VPC",
        "module.alb_security_group": "ALB Security Group",
        "module.alb": "ALB",
        "aws_route53": "Route53"
    }
    
    # Start building the simplified DOT file
    simplified_dot = '''digraph {
    rankdir = "TB"
    
    # Node definitions with better styling
    node [shape=box, style="rounded,filled", fontname="Helvetica", fillcolor=lightblue]
    
    # Modules
    "AWS Provider" [fillcolor=lightgrey]
    "VPC Module" [description="VPC with public/private subnets"]
    "ALB Security Group Module" [description="Security group for ALB"]
    "ALB Module" [description="Application Load Balancer"]
    "Route53" [description="DNS configuration"]

    # Variables
    node [shape=note, fillcolor=lightyellow]
    "Variables" [label="Infrastructure Variables\\n- Environment\\n- AWS Region\\n- VPC CIDR\\n- Subnet CIDRs\\n- Domain Name\\n- Certificate ARN"]

    # Dependencies
    "Variables" -> "AWS Provider"
'''
    
    # Extract relationships from the original graph
    relationships = set()
    for line in input_content.split('\n'):
        for source_module in modules:
            for target_module in modules:
                if source_module in line and target_module in line and "->" in line:
                    source = modules[source_module]
                    target = modules[target_module]
                    if source != target:
                        relationships.add(f'    "{source}" -> "{target}"')

    # Add relationships to the graph
    simplified_dot += "\n".join(sorted(relationships))
    simplified_dot += "\n}"
    
    return simplified_dot

def main():
    # Read from stdin
    input_content = sys.stdin.read()
    simplified_dot = simplify_terraform_graph(input_content)
    print(simplified_dot)

if __name__ == "__main__":
    main()