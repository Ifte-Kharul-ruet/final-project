import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product-screen';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');
  var _isInit = true;

  Map<String, String?> _initValues = {
    'title': ' ',
    'description': ' ',
    'price': ' ',
    'imageUrl': ' ',
  };
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    //print(productId);
    if (productId != 'no') {
      if (_isInit) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);

        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    } else {
      _initValues = {
        'title': '',
        'description': '',
        'price': '',
        'imageUrl': '',
      };
      _imageUrlController.text = '';
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https') ||
          !_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg')) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (_editedProduct.id != '') {
      Provider.of<Products>(context, listen: false)
          .updateProducts(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }

    Navigator.of(context).pop();
    //   print(_editedProduct.title);

    //   print(_editedProduct.price);

    //   print(_editedProduct.description);

    //   print(_editedProduct.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Provide a value';
                  } else {
                    return null;
                  }
                },
                onSaved: (val) {
                  if (val != null)
                    // ignore: curly_braces_in_flow_control_structures
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        isFavourite: _editedProduct.isFavourite,
                        title: val,
                        description: _editedProduct.description,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                //Price Validator
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please Enter a Valid Number';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Please enter a number greater than zero';
                  }
                  return null;
                },
                onSaved: (val) {
                  if (val != null)
                    // ignore: curly_braces_in_flow_control_structures
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        isFavourite: _editedProduct.isFavourite,
                        title: _editedProduct.title,
                        description: _editedProduct.description,
                        price: double.parse(val),
                        imageUrl: _editedProduct.imageUrl);
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                //textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                onSaved: (val) {
                  if (val != null)
                    // ignore: curly_braces_in_flow_control_structures
                    _editedProduct = Product(
                        id: _editedProduct.id,
                        isFavourite: _editedProduct.isFavourite,
                        title: _editedProduct.title,
                        description: val,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl);
                },
                //Description Validator
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter Description';
                  }
                  if (value.length < 10) {
                    return 'Should be at least 10 character long';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      )),
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Enter a Url')
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.cover,
                              clipBehavior: Clip.hardEdge,
                            )),
                  Expanded(
                    child: TextFormField(
                      // initialValue: _initValues['imageUrl'],
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onSaved: (val) {
                        if (val != null)
                          // ignore: curly_braces_in_flow_control_structures
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              isFavourite: _editedProduct.isFavourite,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: val);
                      },
                      //image Validator
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a image Url';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'please enter a valid url';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('jpeg')) {
                          return 'Please enter a valid Image URL';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
