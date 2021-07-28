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



//引数としてのクロージャ

//引数としてクロージャを使用する場合、「属性」と、「　トレイリングクロージャ」というものがある
//属性 => クロージャに対する付加情報
//トレイリングクロージャ => クロージャを引数に取る関数の可読性を高めるもの


//属性の指定方法  属性には、escaping属性と、autoclosure属性が存在する。

//第二引数をautoclosure属性が指定されたクロージャ ↓

func or (_ lhs: Bool, _ rhs: @autoclosure () -> String) -> String {
    if lhs {
        return "lhsが選択されました"
    } else {
        return rhs()
    }
}

or(false, "rhsで選択された文章")


//escaping属性 => 非同期的に実行されるクロージャ

var queue = [() -> Void]() //クロージャ型が入る配列を定義

func enqueue(operation: @escaping () -> Void){  //引数に、escaping属性を持つクロージャ型を指定する
    queue.append(operation)  //引数に受け取った値を配列に追加
}

enqueue {  //ここで、配列にクロージャ（行う処理）を追加していくイメージ
    print("一つ目の要素") //ここで、引数であるクロージャを配列に追加するために、一旦関数のスコープ外で保持する必要があるため、escaping属性が必要となる？？
}

enqueue {
    print("二つ目の要素")
}

queue.forEach({ $0() })  //$0という記述で、引数のないクロージャを単純に実行しているという意味合いとなる。

//queueという配列に引数で受け取ったクロージャを保持していなくてはならないので、escaping属性が必要となる？ 配列で、引数で受け取ったクロージャを保持しておかないといけないので、escaping属性が必要となる。

//escaping属性を必要としない場合

func executeTwice(operation: () -> Void) {  //
    operation()
    operation()
}
executeTwice {  //今回の関数では、引数で受け取ったクロージャをただ2回実行するだけのプログラムであり、情報を保持する必要がないのでescaping属性は必要がない。
    print("クロージャを実行しています。")
}


//クロージャを引数に用いて、遅延評価を行う方法ーーーーーーーーーーーーーーーーーーー()

//引数を関数かクロージャにする違いでの挙動の変化

//引数を二つとも関数で取った場合

func or1(lhs:Bool,rhs:Bool) -> Bool{
    
    if lhs {
        print("lhs-true")
        return true
    } else {
        print("rhs")
        return rhs
    }
}

func lhs1() -> Bool {
    print("lhs関数を実行します")
    return true
}

func rhs1() -> Bool {
    print("rhs関数を実行します")
    return false
}

//or1(lhs: lhs1(), rhs: rhs1())  //関数を引数に取ると、現在のようなlhs関数だけの使用だけで処理が終わるような場合でも、rhs関数も実行してしまっており、処理速度が落ちる。
//理由 -> 引数に使用される関数は、関数の正格効果によるものである。


//第二引数を関数ではなく、クロージャで作成することによって、必要になるまで処理を行わないようにすることができる ↓



func or2(lhs:Bool,rhs: () -> Bool) -> Bool{  //第二引数をクロージャに変更
    
    if lhs {
        print("lhs-true")
        return true
    } else {
        let rhs = rhs()
        print("rhs")
        return rhs
    }
}

func lhs2() -> Bool {
    print("lhs関数を実行します")
    return true
}

func rhs2() -> Bool {
    print("rhs関数を実行します")
    return false
}

//or2(lhs: lhs2(), rhs: {return rhs2()})   //第二引数を、rhs()という関数を返す処理を行うクロージャで作成することで、必要な場合にのみ処理を行うようにできる.
//これを、遅延評価という

//この方法だと、メリットとして、不必要な処理の削減ができる。しかし、デメリットとして、呼び出し側の引数の記述が煩雑になってしまうデメリットがある。
//ここでのメリットを享受しつつ、デメリットを回避するための属性が、autoclosure属性である。

func or3(lhs:Bool,rhs: @autoclosure () -> Bool) -> Bool{  //@autoclosure属性を付与することで、引数をクロージャで包むという処理を暗黙的に行ってくれる。
    
    if lhs {
        print("lhs-true")
        return true
    } else {
        let rhs = rhs()
        print("rhs")
        return rhs
    }
}

func lhs3() -> Bool {
    print("lhs関数を実行します")
    return false
}

func rhs3() -> Bool {
    print("rhs関数を実行します")
    return false
}

or3(lhs: lhs3(), rhs: rhs3())  //引数の記述がautoclosure属性によって、簡略化することができる。


//トレイリングクロージャについて  ->  関数の最後の引数がクロージャだった場合に、（）外にクロージャを記述する方法


func trailingFunc1(parameter:Int, handler: (String) -> Void) {
    handler("\(parameter)というクロージャ")
}

//トレイリングクロージャを使用しなかった場合

trailingFunc1(parameter: 1, handler: {String in print("\(String)を表示しています(トレイリング不使用)")})

//トレイリングクロージャを使用した場合
//処理の流れ  parameter引数を受け取った関数が、handlerというクロージャを起動 ->  "\(parameter)というクロージャ"という引数を使ってhandlerクロージャが実行される。
trailingFunc1(parameter: 10) { String in
    print("\(String)を表示しています。(トレイリング使用)")

}

//引数がクロージャだけのものだけだった場合は、関数実行時の（）の記述も必要がなくなる

func trailingFunc2(handler: (Int) -> Int){
    handler(10)
}

trailingFunc2 { int in
    return int * 100
}

//クロージャとしての関数 -> 例：mapの引数として、名前をつけたクロージャ関数を利用することで、可読性の高いコードを書く

//まず、与えられた数値型を2倍にして返す関数（クロージャ）を作成する
func double1(x: Int) -> Int {
    return x * 2
}

let array1 = [1,2,3,4,5]

let doubleArray1 = array1.map(double1) //mapは、引数にクロージャを必要とするので、あらかじめ準備しておいたものを使うことができる
type(of: double1) //クロージャを指定した変数名は、引数を指定しなければ、クロージャそのものとして認識される
type(of: double1(x: 10))  //引数を指定した場合は、クロージャを実行した後の戻り値として扱われる。



//クロージャを用いることで、二次元配列的な配列も、簡単に初期化することができる。
var board:[[Int]] = {
    let sideLength = 3
    let row = Array(repeating: 1, count: sideLength)
    let board = Array(repeating: row, count: sideLength)
    return board
}()

let array8 = Array(repeating: 10, count: 10) //repeatingは配列の値、countは、要素の数を表している。
