//
//  Theme.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

// swiftlint:disable force_unwrapping
// swiftlint:disable nesting

import UIKit

// MARK: - Style
struct Style<View: UIView> {
    let style: (View) -> Void
    
    init(_ style: @escaping (View) -> Void) {
        self.style = style
    }
    
    func apply(to view: View) {
        style(view)
    }
}

// MARK: - Theme
enum Theme {
    static func configureTheme() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: Montserrat.regular.font(size: 15)], for: .normal)
    }
    
    // MARK: - UI Component Styles
    enum Button {
        static let primary = Style<UIButton> {
            $0.setTitleColor(.systemBackground, for: .normal)
            $0.backgroundColor = .label
            $0.titleLabel?.font = Montserrat.regular.font(size: 17)
        }
    }
    
    enum Collection {
        static let primary = Style<UICollectionView> {
            $0.backgroundColor = .systemBackground
            $0.keyboardDismissMode = .onDrag
            $0.alwaysBounceVertical = true
        }
    }
    
    enum Image {
        static let primary = Style<UIImageView> {
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.tintColor = .label
        }
    }
    
    enum Label {
        enum Tiny {
            static let primary = Style<UILabel> {
                $0.textColor = .label
                $0.font = Montserrat.regular.font(size: 11)
            }
        }
        
        enum Small {
            static let primary = Style<UILabel> {
                $0.textColor = .label
                $0.font = Montserrat.regular.font(size: 14)
            }
        }
        
        enum Regular {
            static let primary = Style<UILabel> {
                $0.textColor = .label
                $0.font = Montserrat.regular.font(size: 17)
            }
            
            static let tint = Style<UILabel> {
                $0.textColor = .tintColor
                $0.font = Montserrat.regular.font(size: 17)
            }
        }
        
        enum Large {
            static let primary = Style<UILabel> {
                $0.textColor = .label
                $0.font = Montserrat.regular.font(size: 20)
            }
        }
    }
    
    enum NavigationBar {
        static let primary = Style<UINavigationBar> {
            let titleTextAttributes = [NSAttributedString.Key.font: Montserrat.light.font(size: 20)]
            $0.titleTextAttributes = titleTextAttributes as [NSAttributedString.Key: Any]
            $0.tintColor = .label
            $0.barTintColor = .systemBackground
            $0.backgroundColor = .systemBackground
            $0.isTranslucent = false
            $0.prefersLargeTitles = true
            let largeTitleTextAttributes = [NSAttributedString.Key.font: Montserrat.light.font(size: 27)]
            $0.largeTitleTextAttributes = largeTitleTextAttributes as [NSAttributedString.Key: Any]
        }
    }
    
    enum RefreshControl {
        static let primary = Style<UIRefreshControl> {
            $0.tintColor = .label
        }
    }
    
    enum Table {
        static let primary = Style<UITableView> {
            $0.backgroundColor = .systemBackground
            $0.keyboardDismissMode = .onDrag
            $0.tableFooterView = UIView()
            $0.alwaysBounceVertical = true
        }
    }
    
    enum TextField {
        static let primary = Style<UITextField> {
            $0.tintColor = .label
            $0.font = Montserrat.regular.font(size: 17)
        }
    }
    
    enum TabBar {
        static let regular = Style<UITabBar> {
            $0.barStyle = .default
            $0.tintColor = .label
            $0.barTintColor = .systemBackground
            for item in $0.items ?? [] {
                item.imageInsets = UIEdgeInsets(top: 5.5, left: 0, bottom: -5.5, right: 0)
            }
        }
    }
    
    enum View {
        static let primary = Style<UIView> {
            $0.backgroundColor = .systemBackground
        }
    }
}

// MARK: - Custom Font
enum Montserrat: String, CaseIterable {
    case thin = "Montserrat-Thin"
    case extraLight = "Montserrat-ExtraLight"
    case light = "Montserrat-Light"
    case regular = "Montserrat-Regular"
    case medium = "Montserrat-Medium"
    case semiBold = "Montserrat-SemiBold"
    case bold = "Montserrat-Bold"
    case black = "Montserrat-Black"
    case extraBlack = "Montserrat-ExtraBlack"
    
    func font(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }
}
