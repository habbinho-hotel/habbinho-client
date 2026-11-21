# Octane UI

Use the [Habbinho setup](../README.md#desenvolvimento) and
[agent guide](../AGENTS.md) for this checkout. The sibling `Octane-Renderer/`
is already included and Vite resolves its TypeScript sources directly.

Follow the [UI architecture](docs/ARCHITECTURE.md) for view layout,
shared hooks, snapshots, and tests. For a change to the SDK or protocol,
also read the [renderer guide](../Octane-Renderer/CLAUDE.md).

Run `yarn typecheck`, `yarn test`, and `yarn build` from `Octane/` as
appropriate for the change. `yarn lint:hooks` is available for hook changes.
For an in-game UI check, use the local stack with a browser session. The
[renderer E2E scenarios](../Octane-Renderer/packages/communication/src/e2e/README.md)
exercise the protocol independently of the UI.
