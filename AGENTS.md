# Habbinho Client

- Use o [README da raiz](README.md#desenvolvimento) para instalar, configurar e executar o projeto. `Octane/` contém a UI React. `Octane-Renderer/` contém o SDK, a renderização e o protocolo.
- Consulte a [arquitetura da UI](Octane/docs/ARCHITECTURE.md) para views, hooks e testes, e o [guia do Renderer](Octane-Renderer/CLAUDE.md) para eventos e pacotes.
- Em mudanças de protocolo, confira o registro e o formato do pacote no emulador e no Renderer. Use os [contratos e testes](docs/README.md) para localizar a referência da área.
- Rode as verificações da [CI da raiz](.github/workflows/client.yml) que cobrem a mudança. Use o [guia E2E](Octane-Renderer/packages/communication/src/e2e/README.md) para cenários que precisam do Polaris.
