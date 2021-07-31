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

//コンピューテッドプロパティ -- 値を保持せずに算出されるプロパティ (プロパティ自身では、値を保存しない)

//getキーワードを用いて、値を取得する

struct Computed1{
    var name = "sample"
    
    var body :String {  //コンピューテッドプロパティの記述
        get {  //getキーワードを用いて、nameプロパティを使ってコンピューテッドプロパティを規定している
            print("取得")
            return "Hello!,\(name)"
        }
    }
}

let computed1 = Computed1()
print(computed1.body)


//setキーワードを用いて、値の更新を行う  (何か、連動する値を作成したい場合等に、この方法を使える)
//複数ある変数の値の整合性を必要とする場合に、この方法を使うと良い。

struct Temperature {
    var celsius: Double = 0.0
    
    var fahrenheit: Double {
        get {
            print("get")
            return (9.0 / 5.0 ) * celsius + 32.0
        }
        
        set {  //コンピューテッドプロパティであるfahrenheitの値が変化した際に、ストアドプロパティのcelsiusを更新させるために使用している。
            print("set")
            celsius = ( 9.0 / 5.0 ) * (newValue - 32.0)  //変更後のコンピューテッドプロパティの値には、newValueキーワードを使用してアクセスすることができる。
        }
        
        
//        set(newFahrenheit) {
//            celsius = ( 9.0 / 5.0 ) * (newFahrenheit - 32.0) //newValueの代わりに、自分で変数名を指定することも可能
//        }
        
        
    }
}
var temperature = Temperature()
temperature.celsius = 25
print("摂氏温度は、\(temperature.celsius): 華氏温度は、\(temperature.fahrenheit)")  //ここの処理で、どちらの値も中身が更新されていることがわかる。

temperature.fahrenheit = 32
print("摂氏温度は、\(temperature.celsius): 華氏温度は、\(temperature.fahrenheit)")
