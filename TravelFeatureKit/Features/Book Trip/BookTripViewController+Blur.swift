//
//  BookTripViewController+Blur.swift
//  TravelFeatureKit
//
//  Created by Povilas Staskus on 11/13/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import UIKit

// MARK: - Background Blur

extension BookTripViewController {
    func showBlur() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blurBackground.alpha = 0.5
        }) { _ in
            self.blurHeader.isHidden = false
            self.blurBackground.isHidden = true
            self.blurHeader.alpha = 0.5
        }
    }

    func hideBlur() {
        self.blurHeader.isHidden = true
        self.blurBackground.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.blurBackground.alpha = 0
        }
    }

    func addBlur() {
        blurHeader.style(blurHeaderStyle)

        blurHeader.snp.makeConstraints { make in
            make.edges.equalTo(self.view.snp.edges)
        }

        UIView.parentOfTopMost.addSubviews(
            blurBackground.style(blurBackgroundStyle)
        )

        blurBackground.snp.makeConstraints { make in
            make.edges.equalTo(UIView.parentOfTopMost.snp.edges)
        }
    }
}

// MARK: - Drag

extension BookTripViewController {
    func addDragGestures() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(dragContainer))
        view.addGestureRecognizer(gestureRecognizer)
    }

    @objc private func dragContainer(sender: UIPanGestureRecognizer) {
        guard let bottomConstraint = contentView.bottomConstraint else { return }

        let translation = sender.translation(in: contentView)
        let current = bottomConstraint.constant + translation.y
        if current >= 0 {
            contentView.bottomConstraint!.constant = current
            sender.setTranslation(.zero, in: contentView)
        }

        if sender.state == .ended {
            if bottomConstraint.constant > 60 {
                self.dismiss(animated: true, completion: nil)
            } else {
                contentView.bottomConstraint?.constant = 0
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
}

extension BookTripViewController {
    private func blurBackgroundStyle(_ blur: UIVisualEffectView) {
        blur.alpha = 0
    }

    private func blurHeaderStyle(_ header: UIVisualEffectView) {
        header.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        header.addGestureRecognizer(tapGestureRecognizer)
    }
}
