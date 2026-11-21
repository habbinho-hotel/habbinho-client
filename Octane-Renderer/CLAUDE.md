# Octane Renderer

Use the [Habbinho setup](../README.md#desenvolvimento) and
[agent guide](../AGENTS.md) for this checkout. Vite aliases `@octane/*` to
the source of the renderer packages. Keep public exports and interfaces in
sync with their consumers in `Octane/`.

## Events and snapshots

- [EventDispatcher](packages/events/src/EventDispatcher.ts) dispatches
  synchronously. Preserve listener ordering and the unsubscribe callback
  returned by `subscribe`. Packet consumers can use
  [CommunicationManager.subscribeMessage](packages/communication/src/CommunicationManager.ts).
- Manager snapshots retain their identity until a mutation. Expose the getter
  in `packages/api/` and the implementation, then invalidate and notify after
  the mutation or batch completes. The [React snapshot hooks](../Octane/src/hooks/session/useSessionSnapshots.ts)
  read those values through `useSyncExternalStore`.

## Packets

1. For server-to-client traffic, define the ID in
   [IncomingHeader.ts](packages/communication/src/messages/incoming/IncomingHeader.ts),
   add the event and parser, and register the event in
   [OctaneMessages.ts](packages/communication/src/OctaneMessages.ts).
2. For client-to-server traffic, define the ID in
   [OutgoingHeader.ts](packages/communication/src/messages/outgoing/OutgoingHeader.ts),
   add the composer, and register it in `OctaneMessages`.
3. Export the new types through the relevant `index.ts` files. Check both
   directions against Polaris for ID, field order, types, and optional fields.

`bytesAvailable` is a boolean for the whole packet. Use it for optional
packet tails. In [RoomUnitParser](packages/communication/src/messages/parser/room/unit/RoomUnitParser.ts),
read `borderId` after the entry fields of every applicable user record, as
the server emits it there. A packet-wide check can consume part of the next
record when the field is missing.

Run `node scripts/packet-coverage.mjs` from `Octane-Renderer/` to find used
classes missing from the registry and repeated header registrations. Use the
[packet manifest](protocol/packet-field-contracts.json) and
[contract tests](packages/communication/src/messages/contracts/__tests__/) for
wire format. For variable layouts, see the relevant composer and parser,
such as the [Furnidata contract](../docs/furnidata.md).

## Checks

Use `yarn compile:fast` and `yarn test`. For a live protocol scenario, see the
[renderer E2E guide](packages/communication/src/e2e/README.md).
