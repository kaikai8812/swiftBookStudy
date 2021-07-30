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

// 7.3 プロパティについて 型に紐づいた値 ーーーーーーーーーーーーーーーーーーーーーーーーーーー

//プロパティの種類 インスタンスプロパティと、スタティックプロパティ

//インスタンスプロパティ  =>  型のインスタンスに基づくプロパティ
//特に何も記述せずにプロパティを作成した場合は、このインスタンスプロパティになる

//スタティックプロパティ => 型自身に紐づくプロパティ
//staticと定数を定義する前に記述することで、型自身に紐づいた定数を作成することができる。
//スタティックプロパティは、宣言時に最初から値を決めておく必要がある。

struct Greeding{
    var name:String = "太郎" //"太郎"という初期値を持ったインスタンスプロパティを作成
    static let language = "English" //スタティックプロパティを作成
    
    func helloFunc(){
        print("\(self.name)さんは、\(Self.language)を使用します。")  //selfで、インスタンスプロパティを使用、Selfで、スタティックプロパティを使用
    }
}

var greet1 = Greeding()
var greet2 = Greeding()

greet2.name = "二郎"  //インスタンスプロパティの値を変更

//プロパティが、greet1,greet2それぞれに紐づいたインスタンスプロパティなので、下記は値が異なっていることがわかる
greet1.name //太郎
greet2.name //二郎

greet1.helloFunc()
greet2.helloFunc()
print(Greeding.language)  //型自身.スタティックプロパティ　で、アクセスすることができる。

//ストアドプロパティ => 値を保持するプロパティのこと

struct stadPr {
    //ストアドプロパティは、以下のように普通に記述することで作成される。
    var variable = 123
    let constant = 456
    static var staticVaraiable = 789
    static let staticconstant = 890
}

//プロパティオブサーバ => ストアドプロパティの値の変更を監視し、変更前と変更後、それぞれのタイミングで処理を行うもの

struct ofServePro {
    var name:String = "青山" {
        willSet{  //プロパティのnameが変更される直前に実行される。
            print("変更前の名前は、\(name)です。これから、\(newValue)に変更します。")  //変更後の値は、newValueという変数が暗黙的に使用することができる。
        }
        didSet{  //nameの更新が終了時に実行される。
            print("\(name)に変更が完了しました。")
        }
    }
}

var ofServe = ofServePro()
ofServe.name = "青山改" //nameの値を更新したので、規定したwillsetとdidsetの実行が行われる。


//レイジーストアドプロパティ => アクセス時まで初期化を遅延させるプロパティ

struct lazystadPr {
    
    //通常のストアドプロパティ
    var value:Int = {
        print("通常のストアドプロパティの初期化")
        return 1
    }()
    
    //レイジーストアドプロパティ
    lazy var lazyValue: Int = {
        print("レイジーストアドプロパティの初期化")
        return 2
    }()
    
    //レイジーストアドプロパティは、普通のインスタンスの初期化の後に処理されるため。他のプロパティの値を使った定義などをすることができる。
    lazy var lazyValue2: Int = {
        return value * 10  //通常のストアドプロパティの値を初期化に用いている。
    }()
    
}

var lazystad = lazystadPr()  //インスタンス化した時点では、valueの初期化は行われているが、lazyValueの初期化は行われていないことがわかる。
print("valueの値は,\(lazystad.value)です。")
print("レイジーストアドの値は、\(lazystad.lazyValue)です。") //レイジーストアドプロパティの値にアクセスした時点で、値の初期化が行われていることが確認できる。
