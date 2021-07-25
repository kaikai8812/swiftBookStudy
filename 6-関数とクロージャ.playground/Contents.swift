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


//引数について------
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

//戻り値について------

//戻り値がない関数について => 戻り値がvoid型であるという考え方である
//void型とは => 要素の型が0個のTuple型のことを、void型という。nilは、値があり得る場所に値がないことを示すが、void型はそもそもから値がないことを示す。

//void型を戻り値に設定する
func voidTest() -> Void {
    print("voidTestです。")
}

voidTest()

//コンパイラによる戻り値のチェック

func convertInt(from string:String) -> Int{
    type(of: Int(string))
    return Int(string)!     //Int()でキャストした値は、Optional(Int)型になるので、!をつけてアンラップを行なっている。
}

convertInt(from: "100")

//暗黙的なreturn  =>  関数が戻り値の返却のみの処理である場合、returnの記述を省略することができる。

func implctReturn(name : String) -> String{
    "hello,\(name)さん！！"  //関数内の処理が戻り値を返すだけだった場合、retrunの記述を省略することができる。
//    print("引数は\(name)です")　　左記のような違う処理を含むと、retrunを書かなくてはいけなくなる。
}
print(implctReturn(name: "山田孝之"))

//6.3 クロージャーについて ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

//そもそも、クロージャとは? => スコープ内の変数や定義を保持したひとまとまりの処理のこと
//関数との違い => 名前が不要、型推論によって、型の定義が不要であるなど、関数より手軽に使用することができる.


//定義方法

let closureSample = { (x :Int, y: Int) -> Int in  //closureSampleの定義を、クロージャを用いて行なっている。
    return x * 10 + y * 10
}
type(of: closureSample)  //型は、((Int, Int) -> Int).Type型(クロージャの型)となる。
closureSample(10,20)

//クロージャを引数として使用する

func closureToString(int :Int) -> String{
    return String(int)
}

closureToString(int: closureSample(10,20))

//クロージャの型推論

var closure1: (String) -> Int  //String型の引数を持って、Int型の値を返すクロージャ型の変数を定義


//型推論を使用しない場合のクロージャ
closure1 = {(string:String) -> Int in
    return string.count
}
closure1("おはようございます。")

//型推論を利用した場合のクロージャ  -> 先にclosure1という変数を定義している際に(String) -> Int　型という定義をしているため、わざわざ型を指定しなくても、型推論を用いて記述を省略することができる。
closure1  = {string in
    return string.count
}
closure1("こんばんわ")

//クロージャの引数について

//クロージャの引数は、外部引数名とデフォルト引数が使えない代わりに、簡略引数名というものが使用できる。
//簡略引数名を使用した例 ↓

let isEqual: (Int,Int) -> Bool = {  //型アノテーションのしたクロージャ型の変数でないと、簡略引数名を使用することはできない(簡略引数の型推論をすることができないため。)
    return $0 == $1
}

isEqual(100,150)

//実験　引数として受け取った4つの数字を配列に直すクロージャ //簡略引数名を利用している。
let IntToArrayCreate: (Int,Int,Int,Int) -> [Int] = {
    var count = 0
    var array :[Int] = []
    
    array.append($0)
    array.append($1)
    array.append($2)
    array.append($3)
    
    return array
    
}

IntToArrayCreate(10,20,30,40)
//簡略引数名は、非常にシンプルな処理を記述する際には、積極的に使用していくべし！！

let numbers = [10,20,30,40]
let moreThanTwenty1 = numbers.filter {$0 > 20}  //クロージャを用いて、filterメソッドの引数を与えている。$0 は、元の配列の要素を表している。
let moreThanTwenty2 = numbers.filter { int in  //通常の書き方をすると左記のようになり、記述量が増える。
    int > 20
}
moreThanTwenty1
moreThanTwenty2


//クロージャの戻り値についてーーーーーーーーーーーーーーーーーーー

//戻り値がないクロージャ
let emptyReturnValueClosure: () -> Void = {}

//戻り値が一つ存在するクロージャ
let singleReturnValueClosure: () -> Int = {
    return 1
}

//クロージャで定義された変数や定数の扱い

let closureGreeting: (String) -> String
    
    do {  //do文は、スコープを作成する用途でも使用することができる。
        let symbol = "!" //このsymbolは、このスコープ内で作成されたものなので、スコープ外では使用できない。
        closureGreeting = { user in
            return "Hello,\(user)\(symbol)"
        }
    }

closureGreeting("青山さん")  //closureGreetingという変数は、do文のスコープ外で定義されているため、使用することができる。
//print(symbol) これは使用することができない。

let closureCounter : () -> Int
do {
    var count = 0
    closureCounter = {
        count += 1
        print(count)
        return count
    }
}

closureCounter()  //クロージャがキャプチャという機能を用いて、スコープの範囲外であるcountという変数にアクセスすることができる
closureCounter()  //countの値が1 -> 2 に変化していることから、スコープ外の値の保持性もあることがわかる。

//まとめると、キャプチャとは、クロージャの定義がされているスコープ(今回だったらdo文の中)で定義されている変数や定数ならば、クロージャを通じてスコープ外からでもアクセスすることができる機能




