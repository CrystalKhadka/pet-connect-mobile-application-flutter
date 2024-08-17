# Pet Adoption Platform

A Flutter-based mobile application for the Pet Adoption platform, providing
interfaces for adopters to manage pets, handle adoption processes, and
facilitate communication.

## Youtube link

(https://youtu.be/fYdRsjZMczo)

## Features

### Adopter Role

- **Get All Pets**: View all available pets for adoption.
- **Search Pets**: Filter and search for pets based on various criteria such as
  breed, age, and size.
- **Adopted Pets**: Track pets that have been adopted and view their adoption
  status.
- **Favorite Pets**: Add pets to your favorites list for easy access later.
- **Adoption Requests**: Submit adoption requests and track their status.
- **Edit Profile**: Update your user profile, including personal information and
  preferences.
- **Donation**: Make donations to support the care and sheltering of pets.
- **Chat**: Communicate with pet owners directly through a built-in chat
  feature.

## UI/UX Design

- **Figma**: Used for wireframing and designing the UI components to ensure a
  consistent and intuitive user experience.
- **Material Design**: Implemented Material Design principles to provide a
  clean, modern, and user-friendly interface.
- **Responsive Design**: Tailored the interface for multiple device types,
  ensuring an optimal user experience on mobile devices.
- **User-Centered Design**: Focused on creating a seamless experience by
  understanding the needs of adopters, ensuring that all features are easily
  accessible and intuitive to use.

## Technology Stack

### Frontend

- **Flutter**: Core framework used to build a dynamic and cross-platform mobile
  application.
- **Riverpod**: State management library used to manage and centralize
  application state.
- **Clean Architecture**: Ensured maintainability and scalability by separating
  code into layers (data, domain, and presentation).

### Backend

- **Node.js**: Backend runtime environment used to run server-side applications
  and handle API requests.
- **Express.js**: A web application framework for Node.js used to build the
  RESTful API for the platform.
- **MongoDB**: NoSQL database used to store pet listings, user information, and
  adoption records.
- **Socket.io**: Used to implement real-time chat functionality between adopters
  and pet owners.

## API Integration

The Flutter application interacts with the backend through a RESTful API,
managing operations such as pet listing, adoption request handling, user
authentication, and chat functionality.

## Future Works

- **Advanced Pet Matching**: Introduce an AI-based pet matching feature that
  suggests pets to adopters based on their preferences and lifestyle.
- **Social Media Sharing**: Allow users to share pets on social media platforms
  to increase the chances of adoption.
- **Virtual Meet & Greet**: Implement a feature allowing potential adopters to
  have a virtual meeting with the pets before deciding on adoption.
- **Location-Based Filtering**: Implement a location-based filtering system that
  allows adopters to find pets available for adoption near their geographic
  location.
- **Recommendation System**: Develop a recommendation system that suggests pets
  to users based on their browsing history, past adoptions, and user
  preferences.

## Challenges

- **State Management**: Managing complex state across various components,
  particularly with features like chat, user authentication, and pet listings,
  was effectively handled using Riverpod.
- **Chat Integration**: Implementing real-time chat functionality required
  ensuring reliable message delivery and managing various chat states.
- **Responsive Design**: Ensuring that the user interface remained consistent
  and functional across a wide range of devices and screen sizes was
  challenging, but Flutter's responsive design capabilities provided the
  necessary flexibility.
- **API Integration**: Handling API requests for real-time pet updates, user
  authentication, and chat services while maintaining smooth and secure
  communication required thorough testing.

## Appendix

- **Clean Architecture Structure**:
  - `data`: Contains models, DTOs, data sources, and repositories.
  - `domain`: Contains entities, repositories, and use cases.
  - `presentation`: Contains state, view models, views, widgets, and navigators.
