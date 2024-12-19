from python import Python



fn main() raises:
    var os = Python.import_module("os")  # Pythonのosモジュール
    var builtins = Python.import_module("builtins")  # Pythonのbuiltinsモジュール
    var str = Python.import_module("struct")  # Pythonのstructモジュール

    var file_path = "/Users/sharu/Desktop/Warpspace/dat/pcs_output.dat"
    var out: List[SIMD[DType.float32, 1]] = List[SIMD[DType.float32, 1]]()#
    # ファイルの存在を確認
    if not os.path.exists(file_path):
        print("Error: File not found at", file_path)
        return

    # ファイルを開く
    var file = builtins.open(file_path, "rb")
    print("File opened successfully!")
    var count = 0

    try:
        while True:
            print("File Pointer Position:", file.tell())  # ファイルポインタの位置を表示
            var chunk = file.read(4)  # 4バイト読み込む
            print("Read byte length:", len(chunk), "Content:", chunk)#
            if builtins.len(chunk) < 4:
                print("End of File Reached!")
                break # 4バイト未満なら終了

            # バイ��リデータをFloat32に変換
            var value = str.unpack("f", chunk)[0]
            print("Float32 value:", value)
            var value_float = builtins.float(value)#
            print(value_float)
            var value_f = Float32(value_float)
            print(value_f[0])

            #out.append(Float32(value_float))  # Append value_float instead of value
            #out[count] = Float32(value_float)
            count += 1
            

    finally:
        file.close()
        print("File closed successfully.")#