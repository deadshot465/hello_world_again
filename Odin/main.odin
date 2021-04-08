package main

import "core:fmt"
import "core:os"
import "k01"

main :: proc() {
    executables := [1]proc(int){ k01.execute };
    fmt.println("実行したいプログラムを選択してください。");

    for i in 0..<len(executables) {
        if i < 10 {
            fmt.printf("%d) K0%d\t\t", i + 1, i + 1);
        }
    }

    input := make([]byte, 100);
    count, err := os.read(os.stdin, input);
    
    // The lack of documentation makes it really hard to continue.
}