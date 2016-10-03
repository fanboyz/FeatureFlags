//
//  FeatureFlagsViewController.swift
//  FeatureFlags
//
//  Created by Sean Henry RP on 18/08/2016.
//  Copyright © 2016 Rise Project. All rights reserved.
//

import UIKit

class FeatureFlagsViewController: UITableViewController {

    var featureFlagsMutator: FeatureFlagsMutator!
    private var featureFlags = [FeatureFlag]() {
        didSet { tableView.reloadData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard featureFlagsMutator != nil else {
            showMissingDependencyError()
            return
        }
        title = "Feature Flags"
        setUpTableView()
        setUpBackgroundNotification()
        load()
    }

    private func setUpTableView() {
        let switchCellNib = UINib(nibName: "SwitchCell", bundle: NSBundle(forClass: FeatureFlagsViewController.self))
        tableView.registerNib(switchCellNib, forCellReuseIdentifier: "switchCell")
    }
    
    private func setUpBackgroundNotification() {
        NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationDidBecomeActiveNotification, object: nil, queue: nil) { _ in
            self.load()
        }
    }
    
    private func load() {
        featureFlags = featureFlagsMutator.fetch()
    }
    
    private func change(value value: Bool, atIndex index: Int) {
        featureFlagsMutator.update(featureFlags[index], to: value)
    }
    
    private func showMissingDependencyError() {
        let alert = UIAlertController(title: "Error", message: "Missing FeatureFlagsMutator dependency", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
}

extension FeatureFlagsViewController { // UITableViewDataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featureFlags.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("switchCell", forIndexPath: indexPath) as! SwitchCell
        let index = indexPath.row
        cell.name = featureFlags[index].name
        cell.value = featureFlags[index].value
        cell.delegate = self
        return cell
    }
}

extension FeatureFlagsViewController: SwitchCellDelegate {
    
    func cell(cell: SwitchCell, didChangeValue value: Bool) {
        guard let indexPath = tableView.indexPathForCell(cell) else { return }
        change(value: value, atIndex: indexPath.row)
    }
}
