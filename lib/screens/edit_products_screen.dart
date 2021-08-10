import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:provider/provider.dart';

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
  bool _isInit = false;
  Map<String, dynamic> _initValues = {
    'title': '',
    'price': 0,
    'description': "",
    'imgUrl': '',
  };

  @override
  void initState() {
    _imgUrlFocusNode.addListener(_updateImgUrl);
    // _editedProduct = ModalRoute.of(context)!.settings.arguments;
    // TODO: implement initState
    super.initState();
  }

  void _updateImgUrl() {
    if (!_imgUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    final productData = ModalRoute.of(context)?.settings.arguments;
    if (productData != null) {
      final productId = productData as String;
      // print(productId);
      if (productId != null) {
        _editedProduct = Provider.of<Products>(context).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price,
          'description': _editedProduct.description,
          'imgUrl': '',
        };
        _imgUrlController.text = _editedProduct.imgUrl;
      }
    }
    print(_initValues);
    super.didChangeDependencies();
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
    final _isValid = _form.currentState?.validate();
    if (!_isValid!) {
      return;
    }
    _form.currentState?.save();
    _form.currentState?.validate();
    Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    Navigator.of(context).pop();
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
              initialValue: _initValues['title'],
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
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter a value";
                }
                return null;
              },
            ),
            TextFormField(
                initialValue: _initValues['price'].toString(),
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a number";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please enter a valid number";
                  }
                  if (double.parse(value) <= 0) {
                    return "Please enter a value greater than zero";
                  }
                  return null;
                }),
            TextFormField(
                initialValue: _initValues['description'],
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a description";
                  }
                  if (value.length < 10) {
                    return "Too short. Must be longer than 10 characters";
                  }
                  return null;
                }),
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
                    initialValue: _initValues['imgUrl'],
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a URL";
                      }
                      if (!value.startsWith("http") ||
                          !value.startsWith("https")) {
                        return "Please enter a valid URL";
                      }
                      // if (!value.endsWith(".png") ||
                      //     !value.endsWith(".jpg") ||
                      //     !value.endsWith(".jpeg")) {
                      //   return "Please enter a valid image URL";
                      // }
                      return null;
                    }),
              )
            ])
          ]),
        ),
      ),
    );
  }
}
