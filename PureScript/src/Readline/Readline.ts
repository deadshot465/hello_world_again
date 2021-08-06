import readline from 'readline';
import util from 'util';

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

const question = util.promisify(rl.question).bind(rl);

export const _askQuestion = (q: string) => async () => {
    return await question(q);
};

export const _closeAndExit = () => {
    rl.close();
    process.stdin.resume();
    process.stdin.on('data', process.exit.bind(process, 0));
}

export const _writeToStdout = (buffer: string) => () => {
    return process.stdout.write(buffer);
}