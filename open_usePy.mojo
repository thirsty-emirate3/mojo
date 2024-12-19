from python import Python
import os
from sys import llvm_intrinsic
from pathlib import Path, _dir_of_current_file
from builtin.file import open, FileHandle
from os import PathLike



fn main() raises:
    var os = Python.import_module("os")  # Pythonのosモジュール
    var builtins = Python.import_module("builtins")  # Pythonのbuiltinsモジュール
    var str = Python.import_module("struct")  # Pythonのstructモジュール

    var file_path = "/Users/sharu/Desktop/Warpspace/dat/pcs_output.dat"
    var out: List[SIMD[DType.float64, 1]]#
    # ファイルの存在を確認
    if not os.path.exists(file_path):
        print("Error: File not found at", file_path)
        return

    # ファイルを開く
    var file = builtins.open(file_path, "rb")
    print("File opened successfully!")
    out = List[SIMD[DType.float64, 1]](30000)
    var count = 0

    try:
        while True:
            print("File Pointer Position:", file.tell())  # ファイルポインタの位置を表示
            var chunk = file.read(4)  # 4バイト読み込む
            print("Read byte length:", len(chunk), "Content:", chunk)#
            if builtins.len(chunk) < 4:
                print("End of File Reached!")
                break # 4バイト未満なら終了

            # バイ��リデータをFloat64に変換
            var value = str.unpack("f", chunk)[0]
            print("Float64 value:", value)
            var value_f = float(value)
            print(value_f)
            # out.append(Float32(value_float))  # Append value_float instead of value
            out[count] = value_f
            print(out[count])
            count += 1
            

    finally:
        file.close()
        print("File closed successfully.")#
