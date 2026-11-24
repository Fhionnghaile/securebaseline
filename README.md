# SecureBaseline — tested Terraform module library

<!-- at-a-glance -->
> **A library of secure-by-default Terraform modules, so a new environment starts safe.**  
> **Result:** terraform fmt / validate / tflint / trivy / checkov all pass in CI, with every scanner exception written down and justified; Terratest apply-and-destroy tests for the logging and network examples.  
> **Reproduce:** `terraform fmt -check -recursive && tflint --recursive && trivy config . && checkov -d .`  
> ![CI](https://github.com/fhionnghaile/securebaseline/actions/workflows/ci.yml/badge.svg)
>
> **What this is worth:** You opt out of safety deliberately rather than remembering to opt in — the single biggest reducer of cloud-misconfig risk.


Reusable modules that stand up a secure AWS baseline, proven with **lint + security scan + real
apply tests** — the discipline, not just the HCL.

## Modules
| module | what it enforces |
|---|---|
| [`network`](modules/network) | VPC + subnets, **VPC flow logs** (KMS-encrypted, 365-day retention), **default SG locked shut** |
| [`iam-baseline`](modules/iam-baseline) | strong **password policy**, **Access Analyzer**, no wildcards |
| [`logging`](modules/logging) | multi-region **CloudTrail** + validation, **customer-managed KMS key** (rotation on), → **encrypted, PAB, versioned, lifecycle-managed** S3, and → **CloudWatch Logs** for alarms |
| [`guardrails`](modules/guardrails) | **Config rules** flag public S3 / unencrypted / untagged |

Each module ships `versions.tf` (pinned provider), an `examples/` dir, and an inputs/outputs README.

## Quality gates (the whole point)
```bash
terraform fmt -check -recursive
terraform validate
tflint && trivy config . && checkov -d .
cd test && go test -timeout 30m   # Terratest: apply each example into a sandbox, assert, destroy
```
CI (`.github/workflows/ci.yml`, read-only token) runs fmt + validate + **tflint** + **trivy config** + **checkov** on
every push, and Terratest on demand against a sandbox account.

**Scanner exceptions are explicit, not silent.** Four checkov findings are skipped in the code, each with its
reason next to the resource: S3 access logging on the log bucket itself (circular), cross-region replication
(a cost and data-residency decision for the adopter), S3 event notifications and per-delivery SNS (alerting runs
through the CloudTrail → CloudWatch Logs integration instead).

**History, honestly.** Until 24 Nov 2026 CI was failing: the scanners flagged AWS-managed rather than
customer-managed keys, a 90-day flow-log retention, no CloudTrail → CloudWatch integration, no S3 lifecycle,
a write-all workflow token and unpinned provider versions in the examples, and the examples did not expose the
outputs the Terratest files read. All are fixed in the modules above.

## Terratest (`test/`)
- `logging`: applies the example, checks the trail ARN and log bucket are produced, destroys it.
- `network`: applies the example, checks the VPC and the flow log are produced, destroys it.

Next, deeper assertions (planned, not yet written): the default SG has zero rules, the trail is
multi-region with log-file validation, `iam-baseline` exposes no `"*":"*"` policy, and a deliberately
public bucket is reported **NON_COMPLIANT** by `guardrails`.

## License
MIT. Publishable to the Terraform Registry under semver tags.

## Key decisions

- Secure defaults baked in (logging on, public off, least-privilege IAM).
- Tested like code (four static scanners in CI, Terratest apply tests), not eyeballed.
- Composable modules with working examples, so adoption is incremental.

## Scope & limits

- A module library, not a full platform; an org composes them into its own topology.

