import { start } from "https://deno.land/x/denops_std@v0.2/mod.ts";

const brackets: { [name: string]: string} = {
    '(': ')',
    '{': '}',
    '[': ']',
    '"': '"',
    "'": "'",
    '`': '`',
}

const backQuote = '`';

start(async (vim) => {
    vim.register({
        async echo(text: unknown): Promise<unknown> {
            if (typeof text !== "string") {
                throw new Error(
                    `'text' attribute of 'echo' in ${vim.name} must be string`,
                );
            }

            return await Promise.resolve(text);
        },

        async kakkonanCompletion(inputBrackets: unknown): Promise<string> {
            if (typeof inputBrackets !== "string") {
                throw new Error(`'inputBrackets' attribute of 'kakkonanCompletion' in must be a string`)
            }

            const corsorStr = await vim.call('getline', '.');
            if (typeof corsorStr !== "string") {
                throw new Error(`'corsorStr' attribute of 'kakkonanCompletion' in must be a string`)
            }

            const corsorLine = await vim.call('line', '.');
            if (typeof corsorLine !== "number") {
                throw new Error(`'corsorLine' attribute of 'kakkonanCompletion' in must be a number`)
            }

            const corsorCol = await vim.call('col', '.');
            if (typeof corsorCol !== "number") {
                throw new Error(`'corsorCol' attribute of 'kakkonanCompletion' in must be a number`)
            }

            const corsorChar = corsorStr.substr(corsorCol - 1, 1);

            if (inputBrackets == '"' || inputBrackets == "'" || inputBrackets == "`") {
                if (corsorChar == inputBrackets) {
                    return "";
                }
            }

            if (brackets[inputBrackets]) {
                return inputBrackets + brackets[inputBrackets];
            }

            return "";
        },
    })

    vim.execute(`inoremap <expr> ( denops#request("kakkonan", "kakkonanCompletion", ['(']) . "\<left>"`)
    vim.execute(`inoremap <expr> { denops#request("kakkonan", "kakkonanCompletion", ['{']) . "\<left>"`)
    vim.execute(`inoremap <expr> [ denops#request("kakkonan", "kakkonanCompletion", ['[']) . "\<left>"`)
    vim.execute(`inoremap <expr> " denops#request("kakkonan", "kakkonanCompletion", ['"']) != "" ? '""' . "\<left>" : "\<right>"`)
    vim.execute(`inoremap <expr> ' denops#request("kakkonan", "kakkonanCompletion", ["'"]) != "" ? "''" . "\<left>" : "\<right>"`)
    vim.execute(`inoremap <expr> ${backQuote} denops#request("kakkonan", "kakkonanCompletion", ['${backQuote}']) != "" ? '${backQuote + backQuote}' . "\<left>" : "\<right>"`)
})
