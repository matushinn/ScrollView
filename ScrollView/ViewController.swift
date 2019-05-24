//
//  ViewController.swift
//  ScrollView
//
//  Created by 大江祥太郎 on 2019/05/24.
//  Copyright © 2019 shotaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIScrollViewDelegate{

    //スクロールビューをOutlet接続する
    @IBOutlet weak var scrollView: UIScrollView!
    
    //ページコントロールをOutlet接続する
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    //写真のファイル名とタイトルの構造体
    struct Photo {
        var imageName:String
        var title:String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //各ページに表示する写真
        let photoList = [
            Photo(imageName: "sample1", title: "Fly"),
            Photo(imageName: "sample2", title: "Landscape1"),
            Photo(imageName: "sample3", title: "Landscape2"),
            Photo(imageName: "sample4", title: "Tree")
        ]
        
        //サブビューを作る
        let subView = createContentsView(contentList: photoList)
        
        //スクロールビューにサブビューを追加する
        scrollView.addSubview(subView)
        
        //スクロールビューの設定
        //ページ送りする
        scrollView.isPagingEnabled = true
        //コンテンツサイズ
        scrollView.contentSize = subView.frame.size
        //スクロールの開始位置
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        //スクロールビューのデリゲートになる
        scrollView.delegate = self
        
        //ページコントロールを設定する
        pageControl.numberOfPages = photoList.count
        pageControl.currentPage = 0
        //ページコントロールのドットの色
        pageControl.pageIndicatorTintColor = UIColor.red
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
    }
    
    //スクロールビューに追加するコンテンツビューを作る
    func createContentsView(contentList:Array<Photo>) -> UIView{
        //ページを追加するコンテンツビューを作る
        let contentView = UIView()
        
        //1ページの高さと幅
        let pageWidth = self.view.frame.width
        let pageHeight = self.view.frame.height
        let pageViewRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        //写真の縦横サイズ
        let photoSize = CGSize(width: 250, height: 250)
        //ページを並べたコンテンツビュー全体のサイズ
        contentView.frame = CGRect(x: 0, y: 0, width: pageWidth*4, height: pageHeight)
        //ページの背景色
        let colors:Array<UIColor> = [.cyan,.yellow,.lightGray,.orange]
        
        //写真のコンテンツのページを作ってコンテンツビューに追加する
        for i in 0..<contentList.count{
            //写真のファイル名とタイトルを順に取り出す
            let contentItem = contentList[i]
            //ページのビューを作る
            let pageView = createPage(viewRect: pageViewRect, imageSize: photoSize, item: contentItem)
            //ページの表示座標を決める(ページの幅だけずらしていく)
            let left = pageViewRect.width*CGFloat(i)
            let xy = CGPoint(x: left, y: 0)
            pageView.frame = CGRect(origin: xy, size: pageViewRect.size)
            pageView.backgroundColor = colors[i]
            //コンテンツビューにページビューを並べて追加していく
            contentView.addSubview(pageView)
        }
        return contentView
    }
    
    //写真やタイトルがある1ページ分のビューを作る
    func createPage(viewRect:CGRect,imageSize:CGSize,item:Photo) -> UIView{
        let pageView = UIView(frame: viewRect)
        //写真ビューを作ってイメージを設定する
        let photoView = UIImageView()
        let left = (pageView.frame.width - imageSize.width)/2
        photoView.frame = CGRect(x: left, y: 10, width: imageSize.width, height: imageSize.height)
        photoView.contentMode = .scaleAspectFill
        photoView.image = UIImage(named: item.imageName)
        //ラベルを作って写真タイトルを設定する
        let titleFrame = CGRect(x: left, y: photoView.frame.maxY+10, width: 200, height: 21)
        let titleLabel = UILabel(frame: titleFrame)
        titleLabel.text = item.title
        //写真とタイトルとページビューに追加する
        pageView.addSubview(photoView)
        pageView.addSubview(titleLabel)
        return pageView
    }
    
    //スクロールしたページコントロールを更新する
    func scrollViewDidScroll(_ scrollView:UIScrollView){
        //カレントページを調べる
        let pageNo = Int(scrollView.contentOffset.x/scrollView.frame.width)
        
        //表示をカレントページに合わせる
        pageControl.currentPage = pageNo
        
    }


}

