declare const _default: {
    mode: string;
    entry: {
        main: string[];
    };
    output: {
        path: string;
    };
    resolve: {
        extensions: string[];
    };
    module: {
        rules: ({
            test: RegExp;
            exclude: RegExp;
            use: {
                loader: string;
                options: {
                    cacheDirectory: boolean;
                };
            };
        } | {
            test: RegExp;
            exclude: RegExp;
            use: {
                loader: string;
                options?: undefined;
            };
        })[];
    };
};
export default _default;
