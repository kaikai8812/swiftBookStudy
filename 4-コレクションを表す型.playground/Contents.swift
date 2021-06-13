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

