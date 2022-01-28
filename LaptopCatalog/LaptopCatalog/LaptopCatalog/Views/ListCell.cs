using Xamarin.Forms;
//using XamarinApp.Settings;

namespace XamarinApp.Views
{
    public class ListCell : ViewCell
    {
        private readonly Label _lblName;
        private readonly Image _img;

        public ListCell()
        {
            _lblName = new Label
            {
                HorizontalOptions = LayoutOptions.Start,
                VerticalOptions = LayoutOptions.Center,
                Padding = new Thickness(5, 10, 0, 0)
            };

            _img = new Image
            {
                HeightRequest = 200,
                VerticalOptions = LayoutOptions.FillAndExpand,
                Margin = 10
            };

            var cell = new StackLayout
            {
                Orientation = StackOrientation.Horizontal
            };

            var content = new StackLayout
            {
                Orientation = StackOrientation.Vertical,
                VerticalOptions = LayoutOptions.Center
            };

            content.Children.Add(_lblName);
            cell.Children.Add(_img);
            cell.Children.Add(content);

            View = cell;
        }

        public string Name
        {
            get => (string)GetValue(NameProperty);
            set => SetValue(NameProperty, value);
        }

        public string LaptopId
        {
            get => (string)GetValue(IdProperty);
            set => SetValue(IdProperty, value);
        }

        public ImageSource Image
        {
            get => (ImageSource)GetValue(ImageProperty);
            set => SetValue(ImageProperty, value);
        }

        public static readonly BindableProperty NameProperty = BindableProperty.Create($"{nameof(Name)}", typeof(string), typeof(ListCell), "");
        public static readonly BindableProperty IdProperty = BindableProperty.Create($"{nameof(LaptopId)}", typeof(string), typeof(ListCell), "");
        public static readonly BindableProperty ImageProperty = BindableProperty.Create($"{nameof(Image)}", typeof(ImageSource), typeof(ListCell), null);

        protected override void OnBindingContextChanged()
        {
            base.OnBindingContextChanged();

            if (BindingContext != null)
            {
                _lblName.Text = Name;
                _img.Source = Image;
            }
        }
    }
}