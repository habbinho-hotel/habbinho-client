# Documentação do Habbinho Client

## Desenvolvimento

- [Setup e validação](../README.md#desenvolvimento) e [instruções para agentes](../AGENTS.md)
- [Arquitetura da UI](../Octane/docs/ARCHITECTURE.md) e [guia de eventos e pacotes do Renderer](../Octane-Renderer/CLAUDE.md)
- [Testes E2E com Polaris](../Octane-Renderer/packages/communication/src/e2e/README.md)

## Integração com o emulador

- [Furnidata](furnidata.md) explica a origem dos nomes, o editor e a atualização ao vivo.
- [Manifesto de pacotes](../Octane-Renderer/protocol/packet-field-contracts.json) e [testes de contrato](../Octane-Renderer/packages/communication/src/messages/contracts/__tests__/) descrevem IDs, campos e cobertura.
- [Messenger](../Octane/src/hooks/friends/useMessenger.ts) usa IDs de mensagem para o cursor de leitura do histórico. Consulte o [cenário E2E](../Octane-Renderer/packages/communication/src/e2e/messenger.e2e.test.ts) para o fluxo entre cliente e servidor.
- [Earnings](https://github.com/habbinho-hotel/habbinho-emulator/blob/main/docs/earnings-packet-contract.md) documenta os pacotes e as categorias exibidas na UI.

## Histórico e upstream

- Specs e planos registram o desenho original. Consulte os links no topo de cada documento para localizar a implementação atual. [Specs da UI](../Octane/docs/superpowers/specs/) · [Planos da UI](../Octane/docs/superpowers/plans/) · [Specs do Renderer](../Octane-Renderer/docs/superpowers/specs/) · [Planos do Renderer](../Octane-Renderer/docs/superpowers/plans/)
- O [Compose legado](legacy-docker.md) e o [setup direto do Octane](../Octane/docs/local-development-setup.en.md) descrevem fluxos anteriores e de upstream.
