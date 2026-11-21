# Furnidata

O Renderer carrega os nomes, descrições e dados de móveis do endereço configurado
em `furnidata.url`. No servidor, `Item.getDisplayName()` procura o nome pelo
`classname` no Furnidata e usa `items_base.public_name` como fallback.
A [resolução da fonte no Polaris](https://github.com/habbinho-hotel/habbinho-emulator/blob/main/Emulator/src/main/java/polaris/hotel/items/FurnidataSourceResolver.java)
consulta a configuração do Renderer, o diretório de assets e então
`items.furnidata.path`. Uma cópia baixada de uma URL é somente leitura pelo editor.

## Editor e atualização ao vivo

| Pacote | Direção | Dados |
| --- | --- | --- |
| `10046` | Renderer → Polaris | `int items_base.id`, `string` com JSON de `name`, `description` e/ou `structure`. |
| `10044` | Polaris → Renderer | Resultado da operação no Furni Editor. |
| `10047` | Polaris → Renderer | `int mode`. Em modo `0`, seguem `int count` e os registros de texto. Modo `1` solicita recarga do Furnidata e termina após o modo. |

Em modo `0`, cada registro contém, na ordem, `string type` (`S` para piso, `I`
para parede), `int id` (ID do sprite), `string classname`, `string name` e
`string description`. O Renderer aplica o delta por tipo e ID e atualiza as chaves
de localização. Tanto o delta quanto a recarga disparam `octane-localization-updated`,
usado pelo catálogo, inventário e infostand.

Ao salvar nome ou descrição, o Polaris edita a entrada ou cria uma a partir de
`items_base`, usando o ID do sprite no Furnidata. Com dados divididos em tiers,
`items.furnidata.create_tier` escolhe o destino e tem padrão `custom`. Um envio
só de campos estruturais edita uma entrada existente e usa o modo de recarga.
Ao salvar um nome, o emulador também tenta sincronizar `items_base.public_name`.
A UI oferece a ação manual de sincronização quando esse campo está vazio e existe
um nome salvo para o mesmo `classname`.

- [Handler do Polaris](https://github.com/habbinho-hotel/habbinho-emulator/blob/main/Emulator/src/main/java/polaris/messages/incoming/furnieditor/FurniEditorUpdateFurnidataEvent.java)
- [Parser de recarga](../Octane-Renderer/packages/communication/src/messages/parser/furniture/FurnitureDataReloadParser.ts) e [teste do delta](../Octane-Renderer/packages/session/src/__tests__/applyFurnidataDelta.test.ts)
- [Hook do editor](../Octane/src/hooks/furni-editor/useFurniEditor.ts) e [guia de importação de móveis](https://github.com/habbinho-hotel/habbinho-emulator/blob/main/docs/FURNI_IMPORT_PIPELINE.md)
