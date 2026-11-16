# SecureBaseline — tested Terraform module library

<!-- at-a-glance -->
> **A library of secure-by-default Terraform modules, so a new environment starts safe.**  
> **Result:** Terratest behaviour tests + terraform validate / tflint / trivy / checkov in CI; 20 files parse clean.  
> **Reproduce:** `go test ./test/...   # + terraform validate`  
> ![CI](https://github.com/fhionnghaile/securebaseline/actions/workflows/ci.yml/badge.svg)
>
> **What this is worth:** You opt out of safety deliberately rather than remembering to opt in — the single biggest reducer of cloud-misconfig risk.


Reusable modules that stand up a secure AWS baseline, proven with **lint + security scan + real
apply tests** — the discipline, not just the HCL.

## Modules
| module | what it enforces |
|---|---|
| [`network`](modules/network) | VPC + subnets, **VPC flow logs**, **default SG locked shut** |
| [`iam-baseline`](modules/iam-baseline) | strong **password policy**, **Access Analyzer**, no wildcards |
| [`logging`](modules/logging) | multi-region **CloudTrail** + validation → **encrypted, PAB, versioned** S3 |
| [`guardrails`](modules/guardrails) | **Config rules** flag public S3 / unencrypted / untagged |

Each module ships `versions.tf` (pinned provider), an `examples/` dir, and an inputs/outputs README.

## Quality gates (the whole point)
```bash
terraform fmt -check -recursive
terraform validate
tflint && trivy config . && checkov -d .
cd test && go test -timeout 30m   # Terratest: apply each example into a sandbox, assert, destroy
```
CI (`github-workflows/ci.yml`) runs fmt + validate + **tflint** + **trivy config** + **checkov** on
every push, and Terratest on demand against a sandbox account.

## Terratest asserts (not just "it applied")
- `network`: flow logs enabled; default SG has zero rules.
- `logging`: CloudTrail multi-region + log-file validation; log bucket blocks public access + encrypted.
- `iam-baseline`: no `"*":"*"` policy; analyzer exists.
- `guardrails`: a deliberately-public bucket is reported **NON_COMPLIANT**.

## License
MIT. Publishable to the Terraform Registry under semver tags.

## Key decisions

- Secure defaults baked in (logging on, public off, least-privilege IAM).
- Tested like code (Terratest + four static scanners), not eyeballed.
- Composable modules with working examples, so adoption is incremental.

## Scope & limits

- A module library, not a full platform; an org composes them into its own topology.

