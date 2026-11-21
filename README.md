# Habbinho Client

O client web reúne `Octane/` (interface React) e `Octane-Renderer/` (SDK e protocolo). Para subir o hotel, comece pelo [hotel-stack](https://github.com/habbinho-hotel/hotel-stack). O stack monta o pack de gamedata em runtime. O `gamedata/` histórico deste repositório fica fora da imagem.

## Desenvolvimento

Use Node 22.12+ e Corepack. O Yarn 4 vem fixado no `package.json` de cada pasta. Instale as dependências a partir da raiz do repositório.

```sh
corepack enable
(cd Octane-Renderer && yarn install --immutable)
(cd Octane && yarn install --immutable)
```

Com o Polaris acessível pelo edge do stack em `localhost:8080`, renderize as configurações locais e inicie o Vite.

```sh
OCTANE_CONF_DIR="$PWD/Octane/public/configuration" \
  PUBLIC_URL=http://localhost:5173 \
  PUBLIC_API_URL=http://localhost:5173 \
  PUBLIC_WS_URL=ws://localhost:8080/ws \
  sh docker/client/entrypoint.sh --config-only

cd Octane
OCTANE_GAMEDATA_DIR=/caminho/do/pack-revisado \
  AUTH_PROXY_TARGET=http://127.0.0.1:8080 \
  yarn start --host 127.0.0.1
```

O Vite carrega o código do renderer irmão, serve o pack fora da árvore observada e encaminha `/api` para o stack. O navegador abre o WebSocket pela rota `/ws` do edge. O gerador preserva arquivos locais existentes. Se mudar de porta ou host, ajuste as URLs nos arquivos já gerados.

Para validar uma mudança, rode `yarn compile:fast` e `yarn test` em `Octane-Renderer/`, e `yarn typecheck`, `yarn test` e `yarn build` em `Octane/`. A CI na raiz executa esse fluxo. O [guia Docker legado](docs/legacy-docker.md) fica como referência durante a migração.

## Acompanhar upstream

Em checkout raso, rode `git fetch --unshallow origin` antes de sincronizar. Puxe cada subtree separadamente numa branch de integração. Resolva conflitos e abra o PR após testar.

```sh
git subtree pull --prefix=Octane https://github.com/duckietm/Octane.git main
git subtree pull --prefix=Octane-Renderer https://github.com/duckietm/Octane-Renderer.git main
```

## Imagem

Da raiz, `docker build -t habbinho/client:local .` produz a imagem nginx na porta 80. Configure `PUBLIC_URL`, `PUBLIC_API_URL` e `PUBLIC_WS_URL` em runtime. Monte o pack em `/usr/share/nginx/gamedata`. Use a URL base da API sem acrescentar `/api`.

O workflow `Client` pode publicar no GHCR em `linux/amd64` e `linux/arm64`. Revise as licenças dos assets embarcados e a disponibilidade do código-fonte correspondente antes de despachar manualmente uma tag `image-vX.Y.Z` com `publish_image=true`. Promova o digest do índice multiarch em um PR no stack.

Octane e Octane-Renderer têm seus [termos GPLv3](Octane/LICENSE) nas duas árvores. Assets de terceiros podem ter condições próprias. Preserve a procedência e os avisos aplicáveis.
