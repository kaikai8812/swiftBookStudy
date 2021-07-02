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
    default:
        print("default")
    }
}
