import UIKit

//型の内部での、インスタンスへのアクセス

struct SomeStruct {
    let value: Int  //一つ目のvalueは、型内部での定数としてのvalue
    
    init(value:Int) {    //二つ目のvalueは、SomeStructを初期化する際に必要とされる引数のvalue
        self.value = value  //selfを使用すると、型内部での定数としてのvalueとみなされ、右辺のvalueは、初期化の際に引数で渡ってきた値が入ったvalueとみなされる。
    }
    
    func printValue(){
        print(self.value)
    }
}

let some = SomeStruct.init(value: 10) //SomeStructのインスタンス化
some.printValue()  //SomeStructで作成した関数の使用

//型の内部での、型自身へのアクセス
//大文字のSelfを用いると、型自身に紐づくスタティックプロパティや、スタティックメソッドへのアクセスが容易の行える。

struct SomeStruct1 {
    static let sharedValue: Int = 100
    
    func printSharedValue() {
        print(Self.sharedValue)  //Selfキーワードを用いて、スタティックプロパティにアクセスを行なっている。
    }
}

let some1 = SomeStruct1()
some1.printSharedValue()

