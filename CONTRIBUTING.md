# Contributing Guidelines

This document provides instructions for setting up your development environment and contributing to this project.

## Development Setup

### Prerequisites

1. Install required tools:
```bash
# Install pre-commit
pip install pre-commit

# Install terraform-docs
brew install terraform-docs    # macOS
# or
go install github.com/terraform-docs/terraform-docs@v0.16.0    # Go

# Install checkov
pip install checkov

# Install infracost
brew install infracost    # macOS
# or
curl -fsSL https://get.infracost.io | sh    # Linux/macOS

# Install graphviz (for infrastructure diagrams)
brew install graphviz    # macOS
# or
sudo apt-get install graphviz    # Ubuntu/Debian
```

2. Configure AWS credentials:
```bash
# Configure development profile
aws configure --profile development

# Configure production profile
aws configure --profile production
```

### Pre-commit Setup

1. Install pre-commit hooks:
```bash
pre-commit install
```

2. The following hooks will run on each commit:
- terraform_fmt: Formats Terraform code
- terraform_validate: Validates Terraform code
- terraform_tflint: Lints Terraform code
- terraform_checkov: Checks for security issues
- infracost_breakdown: Generates cost estimates
- documentation: Updates graphs and documentation

3. Run hooks manually:
```bash
pre-commit run -a
```

### Development Workflow

1. Create a new branch:
```bash
git checkout -b feature/your-feature-name
```

2. Make your changes and test them:
```bash
# Test in development environment
make init ENV=dev
make plan ENV=dev

# Test in production environment
make init ENV=prod
make plan ENV=prod
```

3. Commit your changes:
```bash
git add .
git commit -m "Your descriptive commit message"
```
Pre-commit hooks will run automatically to validate your changes.

4. Push your changes and create a pull request:
```bash
git push origin feature/your-feature-name
```

## Documentation

- Documentation is automatically generated when you commit
- Infrastructure diagrams are updated automatically
- Cost analysis is generated for the production environment
- Always review generated documentation before pushing changes

## Best Practices

1. **Infrastructure Changes**:
   - Always test changes in development environment first
   - Use workspaces correctly (`dev` vs `prod`)
   - Review generated cost analysis before applying changes

2. **Code Quality**:
   - Follow Terraform best practices
   - Ensure all code is properly formatted
   - Address all checkov security warnings
   - Document all variables and outputs

3. **Commits and PRs**:
   - Write clear commit messages
   - Create focused pull requests
   - Include context and reasoning in PR descriptions
   - Ensure all pre-commit hooks pass

4. **Security**:
   - Never commit sensitive information
   - Use AWS profiles correctly
   - Review security scan results
   - Follow least privilege principle

## Troubleshooting

### Pre-commit Issues

If pre-commit hooks fail:
1. Run `pre-commit run -a` to see detailed errors
2. Fix the reported issues
3. Stage your changes and try committing again

Common issues:
- Missing tools: Ensure all required tools are installed
- Formatting issues: Run `terraform fmt -recursive`
- Security warnings: Review checkov output
- Documentation: Ensure README templates are correct

### Development Environment

If you encounter issues:
1. Ensure AWS credentials are configured correctly
2. Verify you're using the correct workspace
3. Check that all required tools are installed
4. Review error messages in detail

For more help, contact the infrastructure team.
