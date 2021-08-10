import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class EditProductsScreen extends StatefulWidget {
  const EditProductsScreen({Key? key}) : super(key: key);
  static const String routeName = "/edit-product";

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imgUrlController = TextEditingController();
  final _imgUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  Product _editedProduct = Product(
    title: '',
    price: 0,
    imgUrl: "",
    id: '',
    description: "",
  );

  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImgUrl);
    // TODO: implement initState
    super.initState();
  }

  void _updateImgUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      print(_imgUrlController.text);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imgUrlController.dispose();
    _imgUrlFocusNode.removeListener(_updateImgUrl);
    _imgUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    _form.currentState?.save();
    print(_editedProduct.title);
    print(_editedProduct.price);
    print(_editedProduct.imgUrl);
    print(_editedProduct.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product'), actions: [
        IconButton(
          onPressed: _saveForm,
          icon: Icon(Icons.save),
        )
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_priceFocusNode);
              },
              onSaved: (value) {
                _editedProduct = Product(
                  title: value!,
                  price: _editedProduct.price,
                  imgUrl: _editedProduct.imgUrl,
                  id: _editedProduct.id,
                  description: _editedProduct.description,
                );
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              },
              onSaved: (value) {
                _editedProduct = Product(
                  title: _editedProduct.title,
                  price: double.parse(value!),
                  imgUrl: _editedProduct.imgUrl,
                  id: _editedProduct.id,
                  description: _editedProduct.description,
                );
              },
            ),
            TextFormField(
              maxLines: 3,
              focusNode: _descriptionFocusNode,
              decoration: InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              onSaved: (value) {
                _editedProduct = Product(
                  title: _editedProduct.title,
                  price: _editedProduct.price,
                  imgUrl: _editedProduct.imgUrl,
                  id: _editedProduct.id,
                  description: value!,
                );
              },
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.only(top: 8, right: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: _imgUrlController.text.isEmpty
                    ? Text('Enter a URL here')
                    : FittedBox(
                        child: Image.network(
                          _imgUrlController.text,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(labelText: 'Image URL'),
                  controller: _imgUrlController,
                  focusNode: _imgUrlFocusNode,
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  onSaved: (value) {
                    _editedProduct = Product(
                      title: _editedProduct.title,
                      price: _editedProduct.price,
                      imgUrl: value!,
                      id: _editedProduct.id,
                      description: _editedProduct.description,
                    );
                  },
                ),
              )
            ])
          ]),
        ),
      ),
    );
  }
}
