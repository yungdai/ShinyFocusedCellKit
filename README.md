# ShinyFocusedCellKit
Makes CollectionViewCells have an AppleTV like Spotlight


Required:

<b>UICollectionViewCell:</b>

- Adopt ShinyFocusableCell protocol in your UICollectionViewCell
- Adopt property var spotlight: RadialGradientView = RadialGradientView()

```
class CustomCollectionViewCell: UICollectionViewCell, ShinyFocusable {
	var spotlight: RadialGradientView = RadialGradientView()
}
```

<b>UICollectionViewController:</b>

- Adopt ShinyFocusable protocol in your UICollectionViewController
- Adopt property var positoin: CGFloat = 0.0
- Adopt property var shinyCellViewModel: ShinyCellViewModel = ShinyCellViewModel()

Add the following functions into these delegate functions

```
override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {	
	resetSpotlightCells()
}
	
override func scrollViewDidScroll(_ scrollView: UIScrollView) {
	animateSpotlightOnScroll()
}
```

- When dequeueing the cell, make sure you run the setupCell(rect:) function in the cell

```
override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? CustomCollectionViewCell else { fatalError("Not a CollectionViewCell")}
	cell.setupCell(rect: cell.bounds)
	return cell
}
```

