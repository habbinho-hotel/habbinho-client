# Octane UI architecture

Octane owns the React UI. The [renderer](../../Octane-Renderer/README.md)
owns the WebSocket protocol and draws rooms, avatars, and furniture. See the
[Habbinho README](../../README.md#desenvolvimento) for local development.

## Layout

| Location | Responsibility |
| --- | --- |
| `src/components/<area>/<feature>/` | Views and their local helpers |
| `src/hooks/<area>/` | Hooks for an area, with related hooks as siblings |
| `src/common/` | Shared UI primitives and boundaries |
| `src/api/` | Cross-feature adapters, formatters, and packet helpers |
| `src/state/` | Shared-state infrastructure |
| `src/**/*.test.{ts,tsx}` | Vitest tests alongside the subject |

Use the shared Base UI wrappers from [src/common](../src/common/) for controls
such as checkboxes, selects, and buttons. Keep the component's accessible
name and normal keyboard behavior. Use `WidgetErrorBoundary` to isolate
in-room widgets when a failure would affect their siblings.

## State and events

- For renderer-managed state, use the
  [session snapshot hooks](../src/hooks/session/useSessionSnapshots.ts).
  They keep stable fallback values for renderer versions without the getter.
- Use [event hooks](../src/hooks/events/) for renderer pushes and packet
  responses. For shared subscriptions, register the source once at module
  scope with `registerSharedHook` and read it through
  [useSharedHook](../src/state/useSharedHook.tsx). Keep listeners and effects
  in the shared source when exposing separate state and actions.
- Use Zustand selectors for shared UI state. The
  [catalog](../src/hooks/catalog/useCatalog.ts) exposes separate data, UI state,
  and actions. See [catalog effects](../src/hooks/catalog/useCatalogEffects.ts)
  and [catalog queries](../src/hooks/catalog/useCatalogQueries.ts) for server
  data and subscriptions.
- Use [the query adapter](../src/api/octane-query/createOctaneQuery.ts) where
  replies can be correlated reliably. [Navigator search](../src/hooks/navigator/useNavigatorSearch.ts)
  subscribes to events and matches both the tab and the filter before replacing
  visible results. This avoids stale responses overwriting the current search.

## Startup and verification

[bootstrap.ts](../src/bootstrap.ts) initializes renderer configuration before
it imports the React entry point. In local development,
[Vite](../vite.config.mjs) serves the gamedata pack from
`OCTANE_GAMEDATA_DIR` outside the watched source tree.

UI tests use the [Vitest configuration](../vitest.config.mts) and the
[renderer mock](../src/octane-renderer.mock.ts). Extend the mock with the
behavior a test needs. Use the [renderer E2E guide](../../Octane-Renderer/packages/communication/src/e2e/README.md)
for real packets and server persistence.

For design history and integration contracts, see the
[documentation index](../../docs/README.md).
