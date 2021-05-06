part of pisey_ui_kits;

class MyTextFields extends StatelessWidget {
  final TextEditingController? controller;
  final int? maxLines;
  const MyTextFields({Key? key, this.controller, this.maxLines})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(15),
      child: TextFormField(
          maxLines: maxLines,
          style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              labelText: "Title",
              suffixIcon: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  controller!.clear();
                },
              )),
          controller: controller,
          keyboardType: TextInputType.text,
          validator: (value) {
            if (value!.length == 0) return ("News title can't be empty!");
            return null;
          },
          onChanged: (value) {},
          onSaved: (value) {}),
    );
  }
}

class MyTextFieldWithAvatar extends StatelessWidget {
  final String? url;

  const MyTextFieldWithAvatar({Key? key, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 0),
      height: 65,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            child: CircleAvatar(
              radius: 22,
              backgroundColor: Colors.grey[400],
              backgroundImage: NetworkImage(url!),
            ),
            onTap: () {
              // nextScreen(context, ProfilePage());
            },
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 40,
              width: MediaQuery.of(context).size.width * 0.75,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[400]!, width: 0.5),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Search News',
                  style: TextStyle(color: Colors.black45, fontSize: 14),
                ),
              ),
            ),
            onTap: () {
              // nextScreen(context, SearchPage());
            },
          ),
        ],
      ),
    );
  }
}
