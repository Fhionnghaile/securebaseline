# guardrails

AWS **Config managed rules** that flag public S3, unencrypted volumes, and missing required tags.

> **SCPs** (which *deny* these outright) are an AWS Organizations feature created from the management
> account, so they are intentionally out of scope for a standalone sandbox. A Config rule **detects**;
> it does not block the apply.
