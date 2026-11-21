# Communication end-to-end tests

These tests use the renderer's WebSocket stack, a disposable Polaris instance,
and MariaDB. They cover login and reconnect, inventory placement and pickup, and
Messenger history for two users.

## Run locally

1. Follow the [Polaris fixture guide](https://github.com/habbinho-hotel/habbinho-emulator/blob/main/e2e/README.md)
   to set the environment and start the emulator.
2. In the same shell, change to `habbinho-client/Octane-Renderer` and install
   dependencies using Node 22.12+ and Corepack.
3. Run the scenario that covers your change.

```sh
corepack enable
yarn install --immutable
yarn test:e2e:login-reconnect
yarn test:e2e:inventory
yarn test:e2e:messenger
```

All scenarios read `E2E_WS_URL`, `E2E_PROBE_URL`, `E2E_SSO_TICKET`,
`E2E_USER_ID`, and `E2E_ROOM_ID`. Messenger also reads
`E2E_SECOND_SSO_TICKET` and `E2E_SECOND_USER_ID`.

After the inventory scenario, run `bash e2e/verify-inventory-state.sh` from
the `habbinho-emulator` root (`.\e2e\verify-inventory-state.ps1` in PowerShell)
to verify that item `900004` returned to the user's inventory. Stop Polaris
as described in the fixture guide.

## Diagnostics

An authentication timeout usually means the test ticket differs from the
seeded ticket. A room-entry timeout can mean the user or room is missing from
the fixture. Compare the test's packet timeline with the Polaris logs under
`E2E_RUNTIME_DIR` (or the PowerShell runtime directory).

The imported [renderer workflows](../../../../.github/workflows/) contain
upstream CI examples. Use the [client workflow](../../../../../.github/workflows/client.yml)
for the checks enabled in the Habbinho repository.
