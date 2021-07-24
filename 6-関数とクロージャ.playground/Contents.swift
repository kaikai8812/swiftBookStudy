import UIKit

//関数とクロージャ => 処理を一つにまとめて、外部から実行可能にしたもの。
//関数はクロージャの一種である。

// 6.2 関数 名前を持ったひとまとまりの処理  ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

//例 引数を倍にした戻り値を返す関数
func double (_ int: Int) -> Int {
    return int * 2
}

double(10)  //このように、戻り値を代入することがない処理を書いた場合は、PlayGround以外ではエラーが生じるため、下記のように_に代入することで解決する
_ = double(10)
let doubleNumber = double(10)  //戻り値を変数に代入することも可能


//引数について
// 関数の定義時に宣言するもの　=> 仮引数  関数の呼び出し時に指定する引数 => 実引数

//外部引数名と、内部引数名について
//外部引数は、関数の呼び出し時に表示される名前のこと。実際に関数を使用する人がわかりやすいような名前をつけることができる。
//基本的には、内部引数名には冗長的にはならないような名前をつけ、外部引数名にはわかりやすい名前をつけることが一般的である。

func invite(user: String, to group: String) {  //toが外部引数名、groupが内部引数名になる。
    print("\(user)さんは、\(group)に入る予定です")
}

invite(user: "太郎", to: "お餅大好き軍団")

//デフォルト引数について

func greet(user:String = "デフォルトの名前です"){
    print("\(user)さんです！")
}
greet()  //デフォルト値を使用する場合
greet(user: "太郎") //引数を指定する場合

//多くの引数を持つような関数を使用する場合に、用いることもできる

func saunaSearch( name: String,  //複数の引数を指定している。
                  maxTemplature: Int = 120,
                  minTemplature: Int = 80
){
    print("サウナ名は、\(name)です。温度は、最高温度\(maxTemplature),最低温度が\(minTemplature)です。")
}

saunaSearch(name: "湯ラックス")


//インアウト引数  関数外に変更を共有する引数

func inoutGreet(user: inout String) {
    if user.isEmpty {
        user = "Anonymous"  //inout引数を用いると、引数に指定されたもの（今回はinoutUser）の値を、関数外にもかかわらず、更新することができる。
    }
    print("Hello,\(user)")
}

var inoutUser = ""

inoutGreet(user: &inoutUser)
print(inoutUser)  //""で規定したはずのinoutUserの値が、関数内の処理によって"Anonymous"に変更されていることがわかる。

//可変長引数 　任意の個数の値を受け取る引数

func printStrings(strings: String...){  //引数の型指定の後に"..."をつけることで、引数を可変長引数に指定することができる。
    
    if strings.count == 0 {
        print("文字列を入力してください")
        return
    }
    
    for element in strings {
        print("strings: \(element)")
    }
}

printStrings(strings: "1-太郎", "2-山田", "間抜け太郎")

