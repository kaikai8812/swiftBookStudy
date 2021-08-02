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


//イニシャライザ -- インスタンスの初期化処理

struct InitSample1 {
    let to: String
    var body: String {
        return "hello,\(to)"
    }
    
    init(to: String) {  //初期化処理　引数で受け取った値が入った「to」を、定数である「to」に代入している。
         self.to = to
    }
}

var initSample1 = InitSample1(to: "サンプル")  //インスタンス化をする際に、引数を加えて
initSample1.body

//失敗可能イニシャライザについて

struct Items {
    let id: Int
    let title: String
     
    //init?にすることで、失敗の可能性がある状態の初期化処理を行うことができる。
    init?(dictionary: [String: Any]) {  //String型のキーと、Any型のvalueを持つdictionary型が入る配列を規定
        guard let id = dictionary["id"] as? Int, let title = dictionary["title"] as? String else {
            return nil  //初期化に必要な情報がない際には、エラー文を生じさせるため、nilを戻り値として返す
        }
        
        self.id = id
        self.title = title
    }
    
}

let dictionaries: [[String: Any]] = [  //初期化の際に必要な情報を、配列にして保存
    ["id": 1, "title": "1回目"],
    ["id": 2],  //インスタンス化の際に必要な情報がかけている場合には、初期化が失敗する。
    ["id": 3, "title": "3回目"]
    
]

for dictionary in dictionaries {
    if let item = Items(dictionary: dictionary) {
        print(item)
    } else {
        print("失敗しました。")  // 初期化に失敗した場合（引数が足りなかった場合）は、失敗表示を行う。
    }
}


//7.5 メソッド  --  型に基づく関数のこと

//インスタンスメソッド -- インスタンスに紐づくメソッド
//スタティックメソッド -- 型に基づくメソッド

struct methodSample {
    let greeting:String
    static var every:String = "みなさん"
    
    init(greet: String) {
        self.greeting = greet
    }
    
    func greet1(yourName name: String) {   //通常にインスタンスメソッドの作成
        print("\(name)さん、\(greeting)")
    }
    
    static func greet2() {
        print("\(every)、こんにちわ")  //スタティックメソッドで使う変数は、スタティックプロパティでなければならない -> 普通の変数では、インスタンスごとに変わってしまい、型に紐づかなくなってしまうため
    }
}

let method1 = methodSample(greet: "おはようごぁいます！")
method1.greet1(yourName: "太郎")
methodSample.greet2()

//オーバーロード　同名のメソッドでも、引数や戻り値の違いによって、処理を分けるメソッド

//引数によるオーバーロード

struct overroadSample1 {
    
    //引数によるオーバーロード
    func put(value:String) {  //String型の値を受け取るメソッド
        print("\(type(of: value))型の\(value)を受け取りました")
    }
    func put(value:Int) {     //Int型の値を受け取るメソッド
        print("\(type(of: value))型の\(value)を受け取りました")
    }
    
    //戻り値によるオーバーロード
    
    let intValue = 1000
    let stringValue = "サンプル"
    
    func out() -> Int {
        return intValue
    }
    
    func out() -> String {
        return stringValue
    }
}

var overroad1 = overroadSample1()
overroad1.put(value: "あいう")
overroad1.put(value: 100) //受け取る引数の違いによって、実行されるメソッドが変わっていることがわかる

let string1:String = overroad1.out()  //代入されるメソッドの戻り値によって、メソッドが変わっていることがわかる。
let int1:Int = overroad1.out()

// 7.6 サブスクリプト コレクション要素へのアクセス
//サブスクリプトを自分で設定することで、インスタンスに対してインデックス番号でアクセスした際にどのような挙動をするかを決めることができます。

struct Progression {
    var numbers: [Int] = [1,2,3,4,5]
        
    subscript(index:Int) -> Int {
        get {  //値の取得時に、getキーワード下の処理が行われる
            return numbers[index]
        }
        
        set(newValue) {  //値の更新時に、処理が行われる。  //setキーワードを省略すると、値の更新ができないが、コンパイルエラーにはならない。
            numbers[index] = newValue + 10
        }
    }
}

var progress = Progression()
progress.numbers
progress[2]  //getキーワードが使用される
progress[2] = 100  //setキーワードが使用される
progress[2]  //setが適用されているのが確認できる

// エクステンション　型の拡張 -> すでに存在している型に色々な要素(プロパティやメソッドなど)を追加すること

// 例　String型のメソッドを追加する

extension String {  //extensionで、独自の要素を既存の型に追加する。
    
    //関数の追加
    func printSelf() {  //独自の関数を設定。
        print(self)
    }
    
    //コンピューテッドプロパティの追加
    var enclosedString :String {
        get {
            return "「\(self)」"
        }
    }
    
}
let extention1:String = "sample"
extention1.printSelf()    //自分で設定した関数が使用できるようになっている。

print(extention1.enclosedString) //独自に設定したコンピューテッドプロパティが使用可能になっている。

//エクステンションでイニシャライザを追加する

enum WebAPIError : Error { // :の後に型を指定することで、引数の型を指定している？
    case connectionError(Error)
    case fatalError
    
    var title :String {
        switch self {
        case .connectionError:
            return "通信エラー"
        case .fatalError:
            return "致命的エラー"
        }
    }
    
    var message: String {
        switch self {
        case .connectionError(let underlyingError):
            return underlyingError.localizedDescription + "再試行してください"
        case .fatalError:
            return "サポート窓口に連絡してください"
        }
    }
}


extension UIAlertController{ //UIAlertController型の初期化を拡張している
    convenience init(WebAPIError: WebAPIError){
        self.init(title: WebAPIError.title,
                  message: WebAPIError.message,
                  preferredStyle: .alert)
    }
}

let error = WebAPIError.fatalError
error.title
type(of: error)
let alert = UIAlertController(WebAPIError: error) //引数に作成した列挙型の値を取ることで、初期化の引数を増やしている。
alert.message

let alert2 = UIAlertController(title: <#T##String?#>, message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>) //普通はこの形で引数を取るが、あらかじめ初期化用の列挙型の型を取ることによって、この記述を省略している。
