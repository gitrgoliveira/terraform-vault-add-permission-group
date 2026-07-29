# Changelog

All notable changes to this project are documented in this file.

## [0.3.0] - 2026-07-29

### Added

- Validation rejecting `capability_sudo = true` when `secret_path` starts with `sys/` or `auth/`.

### Changed

- README warns that sudo overrides deny policies and requires out-of-band approval; removed a duplicated sentence.

## [0.2.0] - 2026-07-24

### Changed
- BREAKING: removed the `entity_id` input variable. The module now discovers the workload entity automatically via a `vault_identity_entity` data source using the `cluster_name` and `workload_name` inputs. The workload module must be applied first.

## [0.1.0] - 2026-07-07

### Changed
- BREAKING: renamed the `principal_name` input to `workload_name` to align with the "workload" onboarding terminology. Consumers must update the input name.

## [0.0.2] - 2026-06-29

### Changed
- Documentation and version-consistency fixes: corrected the no-code registry pin, the registry-usage version constraint, and the CHANGELOG release header.

## [0.0.1]

### Added
- Initial no-code-ready module implementation.
