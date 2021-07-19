import UIKit

//guard文 => 条件の不成立時に早期退出する分岐

func guardFunction() {

    let value1 = -99
    
    guard value1 >= 0 else {   //条件式がfalseの場合にのみ、{}内の処理が行われる trueの場合は、guard構文が存在するスコープの外に処理が逃げる
        print("0未満の数字です")
        return
    }
    //guard文が適用されたら、この関数内の後の処理はされなくなる。
    
    //guard内の条件式の結果がtrueの場合にのみ下記の処理が適用される。
    print("\(value1)は、0以上の数字であることが保証されています。")
    
}
guardFunction()


//guard let構文の使用方法

func guardletFunction() {
    let a: Any = "太郎"
    
    //guard let文内で定義された変数は、退出した後に使用することができる。
    guard let int = a as? Int else {  //条件式の結果がfalseだった場合に、guard内の処理が実行される。
        print("aは、Int型ではありません")
        return
    }
    
    print("aは、int型です！")
}

guardletFunction()


//guard文とif文の使い分け -----------------------------------------

//二つの引数を受け取り、その和を返すメソッドを通して考える


//if文を用いた場合
func ifAdd(optionalA:Int?, optionalB:Int?) -> Int? {
    
    let a:Int
    if let unwrappedA = optionalA {  //if文を用いて、オプショナルバインディングを行う。
        a = unwrappedA
    } else {
        print("第一引数に値が入っていません。")
        return nil
    }
    
    let b:Int
    if let unwrappedB = optionalB {  //if文を用いて、オプショナルバインディングを行う。
        b = unwrappedB
    } else {
        print("第二引数に値が入っていません。")
        return nil
    }
    
    //if文を用いた場合は、a,bという変数を、if文のスコープ外で規定しなければいけないので、記述量が増える。
    return a + b
}

//guard文を用いた場合
func guardAdd (optionalA:Int?, optionalB:Int?) -> Int?  {
    
    guard let a = optionalA else {
        print("第一引数に値が入っていません。")
        return nil
    }
    
    guard let b = optionalB else {
        print("第二引数に値が入っていません。")
        return nil
    }
    
    //guard内で規定した変数は、条件式がfalseだった場合、その後の処理にも使用できるので、記述量がif文に比べて少なくなる。
    return a + b
}


//switch文の使用方法 ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

//基本的な使用方法
func switchFunc1() {
    
    let a = 10
    
    switch a {
    case Int.min..<0:
        print("aは負の値です")
    case 1..<Int.max:
        print("aは正の値です")
    default:
        print("aは0です")
    }
    
}

//Swiftのswitch文は、制御式の網羅性がコンパイル時にチェックされ、網羅されていない場合は、コンパイルエラーが生じる

func switchFunc2() {
    enum SomeEnum {
        case foo
        case bar
        case baz
    }
    
    let foo = SomeEnum.foo
    
    //下記の記述のように、制御式がとりうる場合(今回は、foo,bar,baz)という状態の全てのケースを網羅していないと、コンパイルエラーが生じる。
    switch  foo {
    case .foo:
        print("foo")
    case .bar:
        print("bar")
    case .baz:
        print("baz")
        
    default:            //defaultは、全てのケースを網羅してしまい、コンパイルエラーを発生させることがなくなり、想定外の値が入ったことに気づきにくくなるため、あまり使わない方が良い。
        print("デフォルトです")
    }
    
}

//switch文　whereキーワード ケースにマッチする条件の追加

//caseの後にsomeを用いてアンラップすることで、オプショナル型の値を条件式で判定することができる。

func switchFunc3(optionalA: Int?) {
    
    switch optionalA {
    case .some(let a) where a > 10:   //whereを使用することで、入ってくる値に条件を加えることができる。
        print("10より大きい数字である、\(a)が存在します。")
    case .some(let a) where a <= 10:    //someをcase分で使用することで、optionalAをアンラップした後、[a]に代入し、Int? => Int型に変換しているテクニック
        print("10以下の数字である、\(a)が存在します。")
    default: break

    }
}

switchFunc3(optionalA: 25)

//ラベル文　break文の制御体制の指定 (ネストされているswitch文があったとして、親のswitch文からbreakしたい場合などに使用する。)

//Any型の値がInt型に変更可能であれば、その値が奇数か偶数かを出力する処理で例を書く

func switchFunc4() {
    let value = 19 as Any
    
    outerSwitch: switch value {     //outerSwitchが、ラベル名
    case let int as Int:   //ここのcaseでAny型の値をInt型にキャストできるかを確認する
        let description:String
        
        switch int {        //ネストされたswitch文で、奇数か偶数かの判断を行う。
        case int where int % 2 != 0:
            description = "奇数"
        case int where int % 2 == 0:
            description = "偶数"
        default:
            print("対象外の値です")
            break outerSwitch  //親のswitch処理まで、全てを終了する
        }
        
        print("値は、\(description)の\(int)です") //descriptionに値が入っていない場合は、ここの処理は適用されないという保証がbreak outerswitch文で保証されているため、ここでコンパイルエラーが生じない。
        
    default:
        print("対象外の値です。")
    }
    
}

//fallthrough文　switch文の次のケースへの制御の移動

func switchFunc5() {
    let a = 2
    
    switch a {
    case 1:
        print("一つ目のケース")
            fallthrough   //fallrhroughで、case 2 の処理も実行される。
    case 2:
        print("二つ目のケース")
    default:
        print("default")
    }
}

//5.3繰り返し構文

//while文とrepeat-while文の違い

//repeat-while文は、最低一回は処理を行いたい時に記述するもの


var a = 2
//先にrepeat文を書いた後、while文の条件を記述する。
repeat {
    print(a)  //aの値に問わず、最初の値はrepeat文があることにより、必ず表示される。
    a += 1
} while a < 5

//繰り返し構文ー実行文の中断方法

//breakを用いて、for文の処理を途中で終了する。
func breakTest(int:Int){
    var containsTwo = false
    let array = [1,2,3,4,5]
    
    for element in array {
        if element == int{
            containsTwo = true
            break  //配列の中にint（引数）が出てきたら、処理を終了する。
        }
        print("\(element)です。")  //breakが適用された場合は、ここのprintが実行されなくなる。
    }
    
}

//for文内でcontinueを用いることで、特定の場合にfor文内の処理をスキップする（for文の次の処理が行われるようになる。）

var continueCount = 0

func continueTest(array: [Int]){
    for element in array {
        continueCount += 1
        if element % 2 == 0{  //もし、要素が偶数だったら
            print("\(element)は、偶数です。")
            continue    //elementが偶数であった場合は、以下の奇数の表示を行う処理をせず、for文の次の処理に移る。
        }
        print("\(element)は、奇数です。")
        if continueCount == array.count {
            print("配列の要素数は\(continueCount)で、全ての要素の検証が終了しました。")
        }
    }
}


//ラベルとbreak文を用いて、上位のfor構文も終了させる。

var labelBreakCount1 = 0
var labelBreakCount2 = 0
var labelBreakArray:[Int] = []

func labelBreakFunc(array: [Int]){
    label: for element in array {
        let arrayelement = element * 2
        labelBreakCount1 += 1
        
        labelBreakArray.append(arrayelement)
        print("\(labelBreakCount1)回目:\(labelBreakArray)")
        
        
        labelBreakCount2 = 0
        for element in array{
            if labelBreakArray.count == 3 {
                print("もし3回目だったら、親の処理まで終了します。")
//                break     //ラベル名を指定しない場合は、子のfor文の処理だけが終了する。
                break label     //子のfor文でも、親のfor文をラベル名で指定してあげれば、終了させることができる。
            }
        }
    }
}

//labelBreakFunc(array: [1,2,3,100])


//遅延実行 defer文を用いて

//スコープの退出時に、確実に実行されて欲しい処理を記述する際に用いることが多い。

var deferCount = 0

func deferFunc() -> Int{
    
    defer { //defer構文の内容は、対象のスコープ内の処理が終了した時点で実行される。　(ここでは、return deferCount文の後に実行される。)
        deferCount += 1
        print("defer内の文章です。")
    }
    print("処理を終了します。")
    return deferCount
}
//
//deferFunc()
//deferCount


//パターンマッチについて 値の構造や性質を表現するパターン


//式パターン => =や、==などを用いて式を評価する場合のパターン


//バリューバインディングパターン　=> varやletを用いて、値を代入することができるかどうかで判断する

func valueBindingFunc(string:String){
    switch string {
    case let matchValue: //変数に値を代入できたらこの条件式が適用される。
        print(matchValue)   //matchValueに値が代入されているので。ここの式が実行される。
    default:
        print("引数が指定されていません")
    }
}
valueBindingFunc(string: "設定した引数です。")


//オプショナルパターン  Optional型の値の有無を評価するパターン

//下記の関数の例では、Optional<Int>型の評価式から、Int型の値を取り出すために、バリューバインディングパターンとオプショナルパターンを組み合わせている。
func optionalFunc(optionalA:Optional<Int>){
    
    switch optionalA {  //optionalAには、オプショナル型の値が入ってくる
    case let unWrappedA?:   //?をつけることによって、optionalAをアンラップした後の値をunWrappedAに代入している。
        print(unWrappedA)
        print(type(of: unWrappedA))
    default:
        print("処理がうまくいきません。")
    }
}

var optionalB:Int? = 10
print(optionalB)
optionalFunc(optionalA: optionalB)

