import UIKit

//コレクションとは、値の集まりのこと。
//タプルは、違う方のものを集めたもの？
//コレクションの基本機能は、Sequrnceプロトコルや、Collectionプロトコルで定義されている。

//配列型の操作について ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

//配列に値を追加する
var integers1 = [1,2,3]
integers1.append(4)  //配列の最後に要素を追加する
integers1.insert(10, at: 2)   //値を挿入する場所を指定して、値を追加する。

//値を結合する
var integers2 = [5,6,7]
let result = integers1 + integers2

//値を削除する
integers2.remove(at: 1)  //削除する位置を指定して削除する
integers2
integers2.removeAll()    //配列内の値を全て削除する(配列自体は無くならない。)

//Dictionary<Key,Value>型  ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー

//辞書型におけるキー値は、HashbleProtocolに準拠している必要がある（キー値には、Array型などは使用できない。）
//以下のように、value値には配列等も入れることが可能。
var dictionary:[String: [Int]]

dictionary = ["1-5": [1,2,3,4,5], "6-10": [6,7,8,9,10]]

//辞書型データへのアクセス方法
//キー値を指定することで、そのキー値に対応するデータを呼び出すことができる。
let value1 = dictionary["1-5"]

//存在しないキー値を指定すると、エラーは起きずに、nilが返り値として返る。
let valueNothing = dictionary["nil"]

//辞書型データの更新、追加、削除方法
//キー値を指定するだけで、色々値を操作できる、

//キー値とvalueの追加
dictionary["addDic"] = [11,22]

//キーと値の削除 -> キー値を指定して、nilを代入することで、キー値ごと削除することができる。
dictionary["1-5"] = nil
dictionary


//範囲型について ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー
let range1 = 1..<4   //Range<Int>型を示す。（4は含まない）
let range2 = 1.9...4.0   //こちらの場合は、4を含む
let range3:CountableRange<Int> = 10..<20
let range4 = ...10   //片側の範囲だけを示すことも可能（この場合は、10以下のInt型の整数を表している。）

//範囲内の数量をカウントできる(Boundが、Int型の場合に限る)
print(range1.count)

//範囲の上限と下限を表すメソッド
range1.upperBound  //上限を示す
range1.lowerBound  //下限を示す

//値が、範囲に含まれているかを確認するメソッド(contains(_:))
range1.contains(2)
range1.contains(200)
