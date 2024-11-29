# Makefile
SHELL := /bin/bash
ENV ?= dev

.PHONY: init plan apply destroy graph docs cost readme

init:
	terraform init -backend-config=config/backend-$(ENV).hcl
	terraform workspace select $(ENV) || terraform workspace new $(ENV)

plan:
	terraform plan -var-file=environments/$(ENV).tfvars

apply:
	terraform apply -var-file=environments/$(ENV).tfvars

destroy:
	terraform destroy -var-file=environments/$(ENV).tfvars

graph:
	# Create docs directory if it doesn't exist
	mkdir -p docs
	# Generate detailed graph
	terraform graph -draw-cycles -type=plan > docs/graph.dot
	dot -Gdpi=300 -Tpng docs/graph.dot > docs/graph.png
	# Generate simplified graph
	terraform graph -draw-cycles -type=plan | python scripts/simplify_graph.py > docs/simplified-graph.dot
	dot -Gdpi=300 -Tpng docs/simplified-graph.dot > docs/simplified-graph.png
	dot -Tsvg docs/simplified-graph.dot > docs/simplified-graph.svg

cost:
	# Generate cost analysis
	mkdir -p docs
	infracost breakdown --path=. --terraform-var-file=environments/prod.tfvars --format=json --out-file=docs/infracost.json
	infracost output --path=docs/infracost.json --format=table --out-file=docs/infracost.md --no-color
	infracost output --path=docs/infracost.json --format=html --out-file=docs/infracost.html
	# Clean up ANSI escape codes and prepare cost section
	sed -i'' -e 's/\x1b\[[0-9;]*m//g' docs/infracost.md
	echo '<!-- BEGIN_COST -->' > docs/cost_section.md
	echo '```' >> docs/cost_section.md
	cat docs/infracost.md >> docs/cost_section.md
	echo ' ' >> docs/cost_section.md
	echo '```' >> docs/cost_section.md
	echo '<!-- END_COST -->' >> docs/cost_section.md

readme: graph cost
	# Update README with cost information
	sed -e '/<!-- BEGIN_COST -->/,/<!-- END_COST -->/!b' \
		-e '/<!-- BEGIN_COST -->/r docs/cost_section.md' \
		-e '/<!-- BEGIN_COST -->/,/<!-- END_COST -->/d' \
		README.template.md > README.md
	# Update Terraform docs
	terraform-docs markdown table --output-file README.md --output-mode inject .

docs: readme
